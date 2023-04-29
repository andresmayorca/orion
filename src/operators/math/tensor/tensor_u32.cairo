//! This module defines and implement a Tensor for u32 values.

use array::ArrayTrait;
use array::SpanTrait;
use option::OptionTrait;

use onnx_cairo::operators::math::tensor::helpers::check_shape;
use onnx_cairo::operators::math::tensor::helpers::check_compatibility;
use onnx_cairo::operators::math::tensor::core::new_tensor;
use onnx_cairo::operators::math::tensor::core::stride;
use onnx_cairo::operators::math::tensor::core::Tensor;
use onnx_cairo::operators::math::tensor::core::TensorTrait;
use onnx_cairo::operators::math::tensor::core::ravel_index;
use onnx_cairo::operators::math::tensor::core::unravel_index;
use onnx_cairo::operators::math::tensor::core::reshape;
use onnx_cairo::operators::math::tensor::helpers::broadcast_index_mapping;
use onnx_cairo::operators::math::tensor::helpers::reduce_output_shape;
use onnx_cairo::operators::math::tensor::helpers::len_from_shape;
use onnx_cairo::operators::math::tensor::helpers::combine_indices;
use onnx_cairo::operators::math::tensor::helpers::find_axis;
use onnx_cairo::operators::math::tensor::helpers::permutation_output_shape;
use onnx_cairo::operators::math::tensor::helpers::prepare_shapes_for_matmul;
use onnx_cairo::operators::math::tensor::helpers::adjust_output_shape_after_matmul;
use onnx_cairo::utils::check_gas;

impl U32Tensor of TensorTrait<u32> {
    /// Creates a new u32 tensor with the given shape and data.
    ///
    /// # Arguments
    /// * `shape` - A span representing the shape of the tensor.
    /// * `data` -  A span containing the data array of u32 elements.
    ///
    /// # Panics
    /// * Panics if the shape and data length are incompatible.
    ///
    /// # Returns
    /// * A new `Tensor<u32>` instance.
    fn new(shape: Span<usize>, data: Span<u32>) -> Tensor<u32> {
        new_tensor(shape, data)
    }

    /// Retrieves the value at the specified indices of an u32 tensor.
    ///
    /// # Arguments
    /// * `self` - The input tensor.
    /// * `indices` - A span representing the indices to access.
    ///
    /// # Panics
    /// * Panics the number of indices provided don't match the number of dimensions in the tensor.
    ///
    /// # Returns
    /// * The u32 value at the specified indices.
    fn at(self: @Tensor<u32>, indices: Span<usize>) -> u32 {
        u32_at_tensor(self, indices)
    }

    /// Finds the minimum value in an u32 tensor.
    ///
    /// # Arguments
    /// * `self` - The input tensor.
    ///
    /// # Panics
    /// * Panics if gas limit is exceeded during execution.
    ///
    /// # Returns
    /// * The minimum u32 value in the tensor.
    fn min(self: @Tensor<u32>) -> u32 {
        u32_min_tensor(*self.data)
    }

    /// Finds the maximum value in an u32 tensor.
    ///
    /// # Arguments
    /// * `self` - The input tensor.
    ///
    /// # Panics
    /// * Panics if gas limit is exceeded during execution.
    ///
    /// # Returns
    /// * The maximum u32 value in the tensor.
    fn max(self: @Tensor<u32>) -> u32 {
        u32_max_tensor(*self.data)
    }

    /// Computes the stride of an u32 tensor.
    ///
    /// # Arguments
    /// * `self` - The input tensor.
    ///
    /// # Panics
    /// * Panics if shape is empty.
    /// * Panics if gas limit is exceeded during execution.
    ///
    /// # Returns
    /// * A span representing the stride of the tensor.
    fn stride(self: @Tensor<u32>) -> Span<usize> {
        stride(*self.shape)
    }

    /// Converts a multi-dimensional index to a one-dimensional index.
    ///
    /// # Arguments
    /// * `self` - The input tensor.
    /// * `indices` - A span representing the indices.
    ///
    /// # Panics
    /// * Panics if the indices are out of bounds for the given shape.
    /// * Panics if gas limit is exceeded during execution.
    ///
    /// # Returns
    /// * The raveled index corresponding to the given indices.
    fn ravel_index(self: @Tensor<u32>, indices: Span<usize>) -> usize {
        ravel_index(*self.shape, indices)
    }

    /// Converts a one-dimensional index to a multi-dimensional index.
    ///
    /// # Arguments
    /// * `self` - The input tensor.
    /// * `index` - The index to unravel.
    ///
    /// # Panics
    /// * Panics if the index is out of bounds for the given shape.
    /// * Panics if gas limit is exceeded during execution.
    ///
    /// # Returns
    /// * A span representing the unraveled indices corresponding to the given index.
    fn unravel_index(self: @Tensor<u32>, index: usize) -> Span<usize> {
        unravel_index(index, *self.shape)
    }

    /// Reshapes an u32 tensor to the target shape.
    ///
    /// # Arguments
    /// * `self` - The input tensor.
    /// * `target_shape` - A span representing the target shape.
    ///
    /// # Panics
    /// * Panics if the target shape is incompatible with the input tensor's data.
    ///
    /// # Returns
    /// * A new `Tensor<u32>` instance with the specified shape.
    fn reshape(self: @Tensor<u32>, target_shape: Span<usize>) -> Tensor<u32> {
        reshape(self, target_shape)
    }

    /// Reduces an u32 tensor along the given axis by summing its elements.
    ///
    /// # Arguments
    /// * `self` - The input tensor.
    /// * `axis` - The axis along which to reduce the tensor.
    ///
    /// # Panics
    /// * Panics if axis is not in the range of the input tensor's dimensions.
    /// * Panics if gas limit is exceeded during execution.
    ///
    /// # Returns
    /// * A new `Tensor<u32>` instance with the specified axis reduced by summing its elements.
    fn reduce_sum(self: @Tensor<u32>, axis: usize) -> Tensor<u32> {
        u32_reduce_sum(self, axis)
    }

    /// Computes the indices of the maximum values along the given axis of an u32 tensor.
    ///
    /// # Arguments
    /// * `self` - The input tensor.
    /// * `axis` - The axis along which to compute the argmax.
    ///
    /// # Panics
    /// * Panics if axis is not in the range of the input tensor's dimensions.
    /// * Panics if gas limit is exceeded during execution.
    ///
    /// # Returns
    /// * A new `Tensor<usize>` instance containing the indices of the maximum values along the specified axis.
    fn argmax(self: @Tensor<u32>, axis: usize) -> Tensor<usize> {
        u32_argmax(self, axis)
    }

    /// Transposes an u32 tensor according to the specified axes.
    ///
    /// # Arguments
    /// * `self` - The input tensor.
    /// * `axes` -  A span containing the array representing the order in which the axes should be transposed.
    ///
    /// # Panics
    /// * Panics if the length of the axes array is not equal to the rank of the input tensor.
    /// * Panics if gas limit is exceeded during execution.
    ///
    /// # Returns
    /// * A new `Tensor<u32>` instance with the axes transposed according to the specified order.
    fn transpose(self: @Tensor<u32>, axes: Span<usize>) -> Tensor<u32> {
        u32_transpose(self, axes)
    }

    /// Performs matrix multiplication between two u32 tensors.
    ///
    /// # Arguments
    /// * `self` - The first tensor.
    /// * `other` - The second tensor.
    ///
    /// # Behavior
    /// The behavior depends on the dimensionality of the tensors as follows:
    /// * If both tensors are 1-dimensional, the dot product is returned.
    /// * If both arguments are 2-dimensional, the matrix-matrix product is returned.
    /// * If the first argument is 1-dimensional and the second argument is 2-dimensional,
    ///   a 1 is prepended to its dimension for the purpose of the matrix multiply. After
    ///   the matrix multiply, the prepended dimension is removed.
    /// * If the first argument is 2-dimensional and the second argument is 1-dimensional,
    ///   the matrix-vector product is returned.
    ///
    /// # Panics
    /// * Panics if the dimension of the tensors is higher than two.
    ///
    /// # Returns
    /// * A new `Tensor<u32>` resulting from the matrix multiplication.
    fn matmul(self: @Tensor<u32>, other: @Tensor<u32>) -> Tensor<u32> {
        u32_matmul(self, other)
    }
}

/// Implements addition for `Tensor<u32>` using the `Add` trait.
impl U32TensorAdd of Add<Tensor<u32>> {
    /// Adds two `Tensor<u32>` instances element-wise.
    ///
    /// # Arguments
    /// * `self` - The first tensor.
    /// * `other` - The second tensor.
    ///
    /// # Returns
    /// * A `Tensor<u32>` instance representing the result of the element-wise addition.
    fn add(self: Tensor<u32>, other: Tensor<u32>) -> Tensor<u32> {
        u32_add_tensor(@self, @other)
    }
}

/// Implements subtraction for `Tensor<u32>` using the `Sub` trait.
impl U32TensorSub of Sub<Tensor<u32>> {
    /// Subtracts two `Tensor<u32>` instances element-wise.
    ///
    /// # Arguments
    /// * `self` - The first tensor.
    /// * `other` - The second tensor.
    ///
    /// # Returns
    /// * A `Tensor<u32>` instance representing the result of the element-wise subtraction.
    fn sub(self: Tensor<u32>, other: Tensor<u32>) -> Tensor<u32> {
        u32_sub_tensor(@self, @other)
    }
}

/// Implements multiplication for `Tensor<u32>` using the `Mul` trait.
impl U32TensorMul of Mul<Tensor<u32>> {
    /// Multiplies two `Tensor<u32>` instances element-wise.
    ///
    /// # Arguments
    /// * `self` - The first tensor.
    /// * `other` - The second tensor.
    ///
    /// # Returns
    /// * A `Tensor<u32>` instance representing the result of the element-wise multiplication.
    fn mul(self: Tensor<u32>, other: Tensor<u32>) -> Tensor<u32> {
        u32_mul_tensor(@self, @other)
    }
}

/// Implements division for `Tensor<u32>` using the `Div` trait.
impl U32TensorDiv of Div<Tensor<u32>> {
    /// Divides two `Tensor<u32>` instances element-wise.
    ///
    /// # Arguments
    /// * `self` - The first tensor.
    /// * `other` - The second tensor.
    ///
    /// # Returns
    /// * A `Tensor<u32>` instance representing the result of the element-wise division.
    fn div(self: Tensor<u32>, other: Tensor<u32>) -> Tensor<u32> {
        u32_div_tensor(@self, @other)
    }
}

/// Retrieves the value at the specified indices in a `Tensor<u32>`.
///
/// # Arguments
/// * `self` - The tensor.
/// * `indices` - A span containing the indices as usize elements.
///
/// # Panics
/// * Panics the number of indices provided don't match the number of dimensions in the tensor.
///
/// # Returns
/// * An u32 value at the specified indices in the tensor.
fn u32_at_tensor(self: @Tensor<u32>, indices: Span<usize>) -> u32 {
    assert(indices.len() == (*self.shape).len(), 'indices not match dimensions');
    let data = *self.data;
    *data.at(self.ravel_index(indices))
}

/// Finds the minimum value in a `Tensor<u32>` array.
///
/// # Arguments
/// * `vec` -  A span containing the data array of u32 elements.
///
/// # Panics
/// * Panics if gas limit is exceeded during execution.
///
/// # Returns
/// * An u32 value representing the minimum value in the array.
fn u32_min_tensor(mut vec: Span::<u32>) -> u32 {
    let mut min_value = 4294967295_u32;
    loop {
        check_gas();

        let current_value = *vec.pop_front().unwrap();

        if (min_value > current_value) {
            min_value = current_value;
        }

        if vec.len() == 0 {
            break ();
        };
    };

    return min_value;
}

/// Finds the maximum value in a `Tensor<u32>` array.
///
/// # Arguments
/// * `vec` -  A span containing the data array u32 elements.
///
/// # Panics
/// * Panics if gas limit is exceeded during execution.
///
/// # Returns
/// * An u32 value representing the maximum value in the array.
fn u32_max_tensor(mut vec: Span::<u32>) -> u32 {
    let mut max_value = 0_u32;
    loop {
        check_gas();

        let current_value = *vec.pop_front().unwrap();

        if (max_value < current_value) {
            max_value = current_value;
        }

        if vec.len() == 0 {
            break ();
        };
    };

    return max_value;
}

// --- BROADCAST OPERATIONS ---

/// Adds two `Tensor<u32>` instances element-wise with broadcasting.
///
/// # Arguments
/// * `self` - The first tensor.
/// * `other` - The second tensor.
///
/// # Panics
/// * Panics if the shape of tensors are not compatible. 
/// * Panics if gas limit is exceeded during execution.
///
/// # Returns
/// * A `Tensor<u32>` instance representing the result of the element-wise addition with broadcasting.
fn u32_add_tensor(self: @Tensor<u32>, other: @Tensor<u32>) -> Tensor<u32> {
    check_compatibility(*self.shape, *other.shape);
    let mut result = ArrayTrait::new();

    let mut n: usize = 0;
    loop {
        check_gas();

        let indices_self = self.unravel_index(n);
        let indices_other = other.unravel_index(n);

        let i = broadcast_index_mapping(*self.shape, indices_self);
        let j = broadcast_index_mapping(*other.shape, indices_other);

        result.append(*(*self.data).at(i) + *(*other.data).at(j));

        n += 1;
        if n == (*self.data).len() {
            break ();
        };
    };

    return TensorTrait::<u32>::new(*self.shape, result.span());
}

/// Subtracts two `Tensor<u32>` instances element-wise with broadcasting.
///
/// # Arguments
/// * `self` - The first tensor.
/// * `other` - The second tensor.
///
/// # Panics
/// * Panics if the shape of tensors are not compatible. 
/// * Panics if gas limit is exceeded during execution.
///
/// # Returns
/// * A `Tensor<u32>` instance representing the result of the element-wise subtraction with broadcasting.
fn u32_sub_tensor(self: @Tensor<u32>, other: @Tensor<u32>) -> Tensor<u32> {
    check_compatibility(*self.shape, *other.shape);
    let mut result = ArrayTrait::new();

    let mut n: usize = 0;
    loop {
        check_gas();

        let indices_self = self.unravel_index(n);
        let indices_other = other.unravel_index(n);

        let i = broadcast_index_mapping(*self.shape, indices_self);
        let j = broadcast_index_mapping(*other.shape, indices_other);

        result.append(*(*self.data).at(i) - *(*other.data).at(j));

        n += 1;
        if n == (*self.data).len() {
            break ();
        };
    };

    return TensorTrait::<u32>::new(*self.shape, result.span());
}

/// Multiplies two `Tensor<u32>` instances element-wise with broadcasting.
///
/// # Arguments
/// * `self` - The first tensor.
/// * `other` - The second tensor.
///
/// # Panics
/// * Panics if the shape of tensors are not compatible. 
/// * Panics if gas limit is exceeded during execution.
///
/// # Returns
/// * A `Tensor<u32>` instance representing the result of the element-wise multiplication with broadcasting.
fn u32_mul_tensor(self: @Tensor<u32>, other: @Tensor<u32>) -> Tensor<u32> {
    check_compatibility(*self.shape, *other.shape);
    let mut result = ArrayTrait::new();

    let mut n: usize = 0;
    loop {
        check_gas();

        let indices_self = self.unravel_index(n);
        let indices_other = other.unravel_index(n);

        let i = broadcast_index_mapping(*self.shape, indices_self);
        let j = broadcast_index_mapping(*other.shape, indices_other);

        result.append(*(*self.data).at(i) * *(*other.data).at(j));

        n += 1;
        if n == (*self.data).len() {
            break ();
        };
    };

    return TensorTrait::<u32>::new(*self.shape, result.span());
}

/// Divides two `Tensor<u32>` instances element-wise with broadcasting.
///
/// # Arguments
/// * `self` - The first tensor.
/// * `other` - The second tensor.
///
/// # Panics
/// * Panics if the shape of tensors are not compatible. 
/// * Panics if gas limit is exceeded during execution.
///
/// # Returns
/// * A `Tensor<u32>` instance representing the result of the element-wise division with broadcasting.
fn u32_div_tensor(self: @Tensor<u32>, other: @Tensor<u32>) -> Tensor<u32> {
    check_compatibility(*self.shape, *other.shape);
    let mut result = ArrayTrait::new();

    let mut n: usize = 0;
    loop {
        check_gas();

        let indices_self = self.unravel_index(n);
        let indices_other = other.unravel_index(n);

        let i = broadcast_index_mapping(*self.shape, indices_self);
        let j = broadcast_index_mapping(*other.shape, indices_other);

        result.append(*(*self.data).at(i) / *(*other.data).at(j));

        n += 1;
        if n == (*self.data).len() {
            break ();
        };
    };

    return TensorTrait::<u32>::new(*self.shape, result.span());
}

/// --- REDUCE OPERATIONS ---

/// Sums the elements along the given axis of an u32 tensor.
///
/// # Arguments
/// * `self` - The input tensor.
/// * `axis` - The axis along which to sum the elements.
///
/// # Panics
/// * Panics if axis is not in the range of the input tensor's dimensions.
/// * Panics if gas limit is exceeded during execution.
///
/// # Returns
/// * A `Tensor<u32>` instance representing the result of the reduction.
fn u32_reduce_sum(self: @Tensor<u32>, axis: usize) -> Tensor<u32> {
    assert(axis <= (*self.shape).len(), 'axis out of dimensions');
    let mut output_data = ArrayTrait::new();

    let output_shape = reduce_output_shape(*self.shape, axis);
    let output_data_len = len_from_shape(output_shape);

    let mut index: usize = 0;
    loop {
        check_gas();

        let output_indices = unravel_index(index, output_shape);
        let current_sum = accumulate_sum(self, output_indices, axis);

        output_data.append(current_sum);

        index += 1;
        if index == output_data_len {
            break ();
        };
    };

    return TensorTrait::<u32>::new(output_shape, output_data.span());
}

/// Helper function that accumulates the sum of elements along a specific axis.
///
/// # Arguments
/// * `input` - The input tensor.
/// * `output_indices` - A span of output indices.
/// * `axis` - The axis along which to accumulate the sum.
///
/// # Panics
/// * Panics if gas limit is exceeded during execution.
///
/// # Returns
/// * An u32 value representing the accumulated sum along the specified axis.
fn accumulate_sum(input: @Tensor<u32>, output_indices: Span<usize>, axis: usize) -> u32 {
    let axis_len = *(*input.shape).at(axis);
    let mut acc = 0_u32;

    let mut axis_index: usize = 0;
    loop {
        check_gas();

        if axis_index == axis_len {
            break ();
        }

        let input_indices = combine_indices(output_indices, axis_index, axis);
        let input_index = ravel_index(*input.shape, input_indices);
        let ele = *(*input.data).at(input_index);

        acc += ele;
        axis_index += 1;
    };

    return acc;
}

/// Returns the indices of the maximum values along the given axis of an u32 tensor.
///
/// # Arguments
/// * `self` - The input tensor.
/// * `axis` - The axis along which to find the maximum values.
///
/// # Panics
/// * Panics if axis is not in the range of the input tensor's dimensions.
/// * Panics if gas limit is exceeded during execution.
///
/// # Returns
/// * A `Tensor<usize>` instance representing the indices of the maximum values along the given axis.
fn u32_argmax(self: @Tensor<u32>, axis: usize) -> Tensor<usize> {
    assert(axis <= (*self.shape).len(), 'axis out of dimensions');

    let mut output_data = ArrayTrait::new();

    let output_shape = reduce_output_shape(*self.shape, axis);
    let output_data_len = len_from_shape(output_shape);

    let mut index: usize = 0;
    loop {
        check_gas();

        let output_indices = unravel_index(index, output_shape);
        let current_argmax = find_argmax(self, output_indices, axis, 0, 0, 0);

        output_data.append(current_argmax);

        index += 1;
        if index == output_data_len {
            break ();
        };
    };

    return TensorTrait::<usize>::new(output_shape, output_data.span());
}

/// Recursive helper function that finds the index of the maximum value along a specific axis.
///
/// # Arguments
/// * `input` - The input tensor.
/// * `output_indices` - A span of output indices.
/// * `axis` - The axis along which to find the maximum value.
/// * `axis_index` - The current index along the specified axis.
/// * `max_value` - The current maximum value found along the axis.
/// * `argmax` - The current index of the maximum value along the axis.
///
/// # Panics
/// * Panics if gas limit is exceeded during execution.
///
/// # Returns
/// * A usize value representing the index of the maximum value along the specified axis.
fn find_argmax(
    input: @Tensor<u32>,
    output_indices: Span<usize>,
    axis: usize,
    axis_index: usize,
    max_value: u32,
    argmax: usize
) -> usize {
    check_gas();

    if axis_index == *(*input.shape).at(axis) {
        return argmax;
    }

    let input_indices = combine_indices(output_indices, axis_index, axis);
    let input_index = ravel_index(*input.shape, input_indices);
    let ele = *(*input.data).at(input_index);

    let (new_max_value, new_argmax) = if ele > max_value {
        (ele, axis_index)
    } else {
        (max_value, argmax)
    };

    return find_argmax(
        input, output_indices, axis, axis_index + 1_usize, new_max_value, new_argmax
    );
}

/// Reorders the axes of an u32 tensor according to the given axes permutation.
///
/// # Arguments
/// * `self` - The input tensor.
/// * `axes` -  A span containing the data representing the axes permutation.
///
/// # Panics
/// * Panics if the length of the axes array is not equal to the rank of the input tensor.
/// * Panics if gas limit is exceeded during execution.
///
/// # Returns
/// * A `Tensor<u32>` instance with the axes reordered according to the given permutation.
fn u32_transpose(self: @Tensor<u32>, axes: Span<usize>) -> Tensor<u32> {
    assert(axes.len() == (*self.shape).len(), 'shape and axes length unequal');

    let output_shape = permutation_output_shape(*self.shape, axes);
    let output_data_len = len_from_shape(output_shape);

    let mut output_data = ArrayTrait::new();

    let mut output_index: usize = 0;
    loop {
        check_gas();

        if output_index == output_data_len {
            break ();
        }

        let output_indices = unravel_index(output_index, output_shape);
        let mut input_indices = ArrayTrait::new();

        let mut output_axis: usize = 0;
        loop {
            check_gas();
            if output_axis == axes.len() {
                break ();
            }

            let input_axis = find_axis(axes, output_axis);
            input_indices.append(*output_indices.at(input_axis));
            output_axis += 1;
        };

        let input_index = ravel_index(*self.shape, input_indices.span());
        output_data.append(*(*self.data).at(input_index));

        output_index += 1;
    };

    return TensorTrait::<u32>::new(output_shape, output_data.span());
}


/// Performs matrix multiplication between two u32 tensors.
///
/// # Arguments
/// * `self` - The first tensor.
/// * `other` - The second tensor.
///
/// # Behavior
/// The behavior depends on the dimensionality of the tensors as follows:
/// * If both tensors are 1-dimensional, the dot product is returned.
/// * If both arguments are 2-dimensional, the matrix-matrix product is returned.
/// * If the first argument is 1-dimensional and the second argument is 2-dimensional,
///   a 1 is prepended to its dimension for the purpose of the matrix multiply. After
///   the matrix multiply, the prepended dimension is removed.
/// * If the first argument is 2-dimensional and the second argument is 1-dimensional,
///   the matrix-vector product is returned.
///
/// # Panics
/// * Panics if the dimension of the tensors is higher than two.
///
/// # Returns
/// * A new `Tensor<u32>` resulting from the matrix multiplication.
fn u32_matmul(self: @Tensor<u32>, other: @Tensor<u32>) -> Tensor<u32> {
    let self_shape = *self.shape;
    let other_shape = *other.shape;
    let self_ndim = (self_shape).len();
    let other_ndim = (other_shape).len();

    assert(self_ndim <= 2 | other_ndim <= 2, 'supports only 1D and 2D matmul');

    //! Case: Both tensors are 1-dimensional
    if self_ndim == 1 & other_ndim == 1 {
        let dot = u32_dot_product((*self).data, (*other).data);
        let mut result_shape = ArrayTrait::new();
        let mut result_data = ArrayTrait::new();
        result_shape.append(1);
        result_data.append(dot);
        return TensorTrait::new(result_shape.span(), result_data.span());
    }

    let (self_shape, other_shape) = prepare_shapes_for_matmul(self_shape, other_shape);

    let (result_data, result_shape) = u32_matrix_multiply(
        *self.data, self_shape, *other.data, other_shape
    );

    let result_shape = adjust_output_shape_after_matmul(result_shape, self_ndim, other_ndim);

    return TensorTrait::<u32>::new(result_shape, result_data);
}

/// Computes the dot product of two 1-dimensional u32 tensors.
///
/// # Arguments
/// * `vec1` - A span containing the data elements of the first vector as u32 elements.
/// * `vec2` - A span containing the data elements of the second vector as u32 elements.
///
/// # Panics
/// * Panics if the lengths of the vectors do not match.
/// * Panics if gas limit is exceeded during execution.
///
/// # Returns
/// * An u32 representing the dot product of the two vectors.
fn u32_dot_product(vec1: Span<u32>, vec2: Span<u32>) -> u32 {
    assert(vec1.len() == vec2.len(), 'vector lengths do not match');

    let mut result: u32 = 0;
    let vec_len = vec1.len();
    let mut idx: usize = 0;

    loop {
        check_gas();
        if idx >= vec_len {
            break ();
        }

        let element_product = *vec1.at(idx) * *vec2.at(idx);
        result += element_product;
        idx += 1;
    };

    return result;
}


/// Computes the matrix multiplication of two 2-dimensional u32 tensors.
///
/// # Arguments
/// * `mat1` - A Span containing the data elements of the first matrix as u32 elements.
/// * `mat1_shape` - A Span containing the shape of the first matrix as usize elements.
/// * `mat2` - A Span containing the data elements of the second matrix as u32 elements.
/// * `mat2_shape` - A Span containing the shape of the second matrix as usize elements.
///
/// # Panics
/// * Panics if the inner dimensions of the matrices do not match.
/// * Panics if gas limit is exceeded during execution.
///
/// # Returns
/// * A Tuple with two elements:
///   * A new Array containing the data elements of the resulting matrix as u32 elements.
///   * A new Array containing the shape of the resulting matrix as usize elements.
fn u32_matrix_multiply(
    mat1: Span<u32>, mat1_shape: Span<usize>, mat2: Span<u32>, mat2_shape: Span<usize>
) -> (Span<u32>, Span<usize>) {
    let m = *mat1_shape.at(0);
    let n = *mat1_shape.at(1);
    let p = *mat2_shape.at(1);

    let mut result_data = ArrayTrait::new();
    let mut result_shape = ArrayTrait::new();
    result_shape.append(m);
    result_shape.append(p);

    let mut i = 0_usize;
    loop {
        check_gas();
        if i == m {
            break ();
        }

        let mut j = 0_usize;
        loop {
            check_gas();
            if j == p {
                break ();
            }

            let mut sum: u32 = 0;
            let mut k = 0_usize;
            loop {
                check_gas();
                if k == n {
                    break ();
                }

                let mat1_index = i * n + k;
                let mat2_index = k * p + j;
                sum += *mat1.at(mat1_index) * *mat2.at(mat2_index);

                k += 1;
            };

            result_data.append(sum);
            j += 1;
        };

        i += 1;
    };

    return (result_data.span(), result_shape.span());
}
