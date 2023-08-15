mod abs_fp16x16;
mod abs_fp8x23;
mod abs_i32;
mod abs_i8;
mod acos_fp8x23;
mod acos_fp16x16;
mod argmax_fp16x16_1D_default;
mod argmax_fp16x16_1D_keepdims_false;
mod argmax_fp16x16_1D_last_index;
mod argmax_fp16x16_2D_default;
mod argmax_fp16x16_2D_keepdims_false;
mod argmax_fp16x16_2D_last_index;
mod argmax_fp16x16_3D_default;
mod argmax_fp16x16_3D_keepdims_false;
mod argmax_fp16x16_3D_last_index;
mod argmax_fp8x23_1D_default;
mod argmax_fp8x23_1D_keepdims_false;
mod argmax_fp8x23_1D_last_index;
mod argmax_fp8x23_2D_default;
mod argmax_fp8x23_2D_keepdims_false;
mod argmax_fp8x23_2D_last_index;
mod argmax_fp8x23_3D_default;
mod argmax_fp8x23_3D_keepdims_false;
mod argmax_fp8x23_3D_last_index;
mod argmax_i32_1D_default;
mod argmax_i32_1D_keepdims_false;
mod argmax_i32_1D_last_index;
mod argmax_i32_2D_default;
mod argmax_i32_2D_keepdims_false;
mod argmax_i32_2D_last_index;
mod argmax_i32_3D_default;
mod argmax_i32_3D_keepdims_false;
mod argmax_i32_3D_last_index;
mod argmax_i8_1D_default;
mod argmax_i8_1D_keepdims_false;
mod argmax_i8_1D_last_index;
mod argmax_i8_2D_default;
mod argmax_i8_2D_keepdims_false;
mod argmax_i8_2D_last_index;
mod argmax_i8_3D_default;
mod argmax_i8_3D_keepdims_false;
mod argmax_i8_3D_last_index;
mod argmax_u32_1D_default;
mod argmax_u32_1D_keepdims_false;
mod argmax_u32_1D_last_index;
mod argmax_u32_2D_default;
mod argmax_u32_2D_keepdims_false;
mod argmax_u32_2D_last_index;
mod argmax_u32_3D_default;
mod argmax_u32_3D_keepdims_false;
mod argmax_u32_3D_last_index;
mod argmin_fp16x16_1D_default;
mod argmin_fp16x16_1D_keepdims_false;
mod argmin_fp16x16_1D_last_index;
mod argmin_fp16x16_2D_default;
mod argmin_fp16x16_2D_keepdims_false;
mod argmin_fp16x16_2D_last_index;
mod argmin_fp16x16_3D_default;
mod argmin_fp16x16_3D_keepdims_false;
mod argmin_fp16x16_3D_last_index;
mod argmin_fp8x23_1D_default;
mod argmin_fp8x23_1D_keepdims_false;
mod argmin_fp8x23_1D_last_index;
mod argmin_fp8x23_2D_default;
mod argmin_fp8x23_2D_keepdims_false;
mod argmin_fp8x23_2D_last_index;
mod argmin_fp8x23_3D_default;
mod argmin_fp8x23_3D_keepdims_false;
mod argmin_fp8x23_3D_last_index;
mod argmin_i32_1D_default;
mod argmin_i32_1D_keepdims_false;
mod argmin_i32_1D_last_index;
mod argmin_i32_2D_default;
mod argmin_i32_2D_keepdims_false;
mod argmin_i32_2D_last_index;
mod argmin_i32_3D_default;
mod argmin_i32_3D_keepdims_false;
mod argmin_i32_3D_last_index;
mod argmin_i8_1D_default;
mod argmin_i8_1D_keepdims_false;
mod argmin_i8_1D_last_index;
mod argmin_i8_2D_default;
mod argmin_i8_2D_keepdims_false;
mod argmin_i8_2D_last_index;
mod argmin_i8_3D_default;
mod argmin_i8_3D_keepdims_false;
mod argmin_i8_3D_last_index;
mod argmin_u32_1D_default;
mod argmin_u32_1D_keepdims_false;
mod argmin_u32_1D_last_index;
mod argmin_u32_2D_default;
mod argmin_u32_2D_keepdims_false;
mod argmin_u32_2D_last_index;
mod argmin_u32_3D_default;
mod argmin_u32_3D_keepdims_false;
mod argmin_u32_3D_last_index;
mod transpose_fp16x16_2d;
mod transpose_fp16x16_3d;
mod transpose_fp8x23_2d;
mod transpose_fp8x23_3d;
mod transpose_i32_2d;
mod transpose_i32_3d;
mod transpose_i8_2d;
mod transpose_i8_3d;
mod transpose_u32_2d;
mod transpose_u32_3d;
mod asin_fp16x16;
mod asin_fp8x23;
mod atan_fp16x16;
mod atan_fp8x23;
mod atan_i32_fp8x23;
mod atan_i32_fp16x16;
mod atan_i8_fp8x23;
mod atan_i8_fp16x16;
mod atan_u32_fp8x23;
mod atan_u32_fp16x16;
mod ceil_fp16x16;
mod ceil_fp8x23;
mod cos_fp16x16;
mod cos_fp8x23;
mod cos_i32_fp8x23;
mod cos_i32_fp16x16;
mod cos_i8_fp8x23;
mod cos_i8_fp16x16;
mod cos_u32_fp8x23;
mod cos_u32_fp16x16;
mod sin_fp16x16;
mod sin_fp8x23;
mod sin_i32_fp8x23;
mod sin_i32_fp16x16;
mod sin_i8_fp8x23;
mod sin_i8_fp16x16;
mod sin_u32_fp8x23;
mod sin_u32_fp16x16;
mod cumsum_fp16x16_1d_default;
mod cumsum_fp16x16_1d_exclusive;
mod cumsum_fp16x16_1d_reverse;
mod cumsum_fp16x16_1d_reverse_exclusive;
mod cumsum_fp16x16_2d_axis_0;
mod cumsum_fp16x16_2d_axis_1;
mod cumsum_fp8x23_1d_default;
mod cumsum_fp8x23_1d_exclusive;
mod cumsum_fp8x23_1d_reverse;
mod cumsum_fp8x23_1d_reverse_exclusive;
mod cumsum_fp8x23_2d_axis_0;
mod cumsum_fp8x23_2d_axis_1;
mod cumsum_i32_1d_default;
mod cumsum_i32_1d_exclusive;
mod cumsum_i32_1d_reverse;
mod cumsum_i32_1d_reverse_exclusive;
mod cumsum_i32_2d_axis_0;
mod cumsum_i32_2d_axis_1;
mod cumsum_i8_1d_default;
mod cumsum_i8_1d_exclusive;
mod cumsum_i8_1d_reverse;
mod cumsum_i8_1d_reverse_exclusive;
mod cumsum_i8_2d_axis_0;
mod cumsum_i8_2d_axis_1;
mod cumsum_u32_1d_default;
mod cumsum_u32_1d_exclusive;
mod cumsum_u32_1d_reverse;
mod cumsum_u32_1d_reverse_exclusive;
mod cumsum_u32_2d_axis_0;
mod cumsum_u32_2d_axis_1;
mod cosh_fp16x16;
mod cosh_fp8x23;
mod cosh_i32_fp8x23;
mod cosh_i32_fp16x16;
mod cosh_i8_fp8x23;
mod cosh_i8_fp16x16;
mod cosh_u32_fp8x23;
mod cosh_u32_fp16x16;
mod sinh_fp16x16;
mod sinh_fp8x23;
mod sinh_i32_fp8x23;
mod sinh_i32_fp16x16;
mod sinh_i8_fp8x23;
mod sinh_i8_fp16x16;
mod sinh_u32_fp8x23;
mod sinh_u32_fp16x16;
mod tanh_fp16x16;
mod tanh_fp8x23;
mod tanh_i32_fp8x23;
mod tanh_i32_fp16x16;
mod tanh_i8_fp8x23;
mod tanh_i8_fp16x16;
mod tanh_u32_fp8x23;
mod tanh_u32_fp16x16;
mod log_fp16x16;
mod log_fp8x23;
mod log_i32_fp8x23;
mod log_i32_fp16x16;
mod log_i8_fp8x23;
mod log_i8_fp16x16;
mod log_u32_fp8x23;
mod log_u32_fp16x16;
mod reduce_sum_fp16x16_1D; 
mod reduce_sum_fp16x16_2D_default; 
mod reduce_sum_fp16x16_2D_keepdims; 
mod reduce_sum_fp16x16_2D_axis_1; 
mod reduce_sum_fp8x23_1D; 
mod reduce_sum_fp8x23_2D_default; 
mod reduce_sum_fp8x23_2D_keepdims; 
mod reduce_sum_fp8x23_2D_axis_1; 
mod reduce_sum_i32_1D; 
mod reduce_sum_i32_2D_default; 
mod reduce_sum_i32_2D_keepdims; 
mod reduce_sum_i32_2D_axis_1; 
mod reduce_sum_i8_1D; 
mod reduce_sum_i8_2D_default; 
mod reduce_sum_i8_2D_keepdims; 
mod reduce_sum_i8_2D_axis_1; 
mod reduce_sum_u32_1D; 
mod reduce_sum_u32_2D_default; 
mod reduce_sum_u32_2D_keepdims; 
mod reduce_sum_u32_2D_axis_1; 
mod exp_fp16x16; 
mod exp_fp8x23; 
mod exp_i32_fp8x23; 
mod exp_i32_fp16x16; 
mod exp_i8_fp8x23; 
mod exp_i8_fp16x16; 
mod exp_u32_fp8x23; 
mod exp_u32_fp16x16; 
mod equal_fp16x16; 
mod equal_fp16x16_broadcast; 
mod equal_fp8x23; 
mod equal_fp8x23_broadcast; 
mod equal_i32; 
mod equal_i32_broadcast; 
mod equal_i8; 
mod equal_i8_broadcast; 
mod equal_u32; 
mod equal_u32_broadcast; 
mod greater_fp16x16; 
mod greater_fp16x16_broadcast; 
mod greater_fp8x23; 
mod greater_fp8x23_broadcast; 
mod greater_i32; 
mod greater_i32_broadcast; 
mod greater_i8; 
mod greater_i8_broadcast; 
mod greater_u32; 
mod greater_u32_broadcast; 
mod less_equal_fp16x16; 
mod less_equal_fp16x16_broadcast; 
mod less_equal_fp8x23; 
mod less_equal_fp8x23_broadcast; 
mod less_equal_i32; 
mod less_equal_i32_broadcast; 
mod less_equal_i8; 
mod less_equal_i8_broadcast; 
mod less_equal_u32; 
mod less_equal_u32_broadcast; 
mod softsign_i32_fp8x23; 
mod softsign_i32_fp16x16; 
mod softsign_i8_fp8x23; 
mod softsign_i8_fp16x16; 
mod softsign_u32_fp8x23; 
mod softsign_u32_fp16x16; 
mod sqrt_fp16x16; 
mod sqrt_fp8x23; 
mod sqrt_i32_fp8x23; 
mod sqrt_i32_fp16x16; 
mod sqrt_i8_fp8x23; 
mod sqrt_i8_fp16x16; 
mod sqrt_u32_fp8x23; 
mod sqrt_u32_fp16x16; 
mod or_fp16x16; 
mod or_fp16x16_broadcast; 
mod or_fp8x23; 
mod or_fp8x23_broadcast; 
mod or_i32; 
mod or_i32_broadcast; 
mod or_i8; 
mod or_i8_broadcast; 
mod or_u32; 
mod or_u32_broadcast; 
mod xor_fp16x16; 
mod xor_fp16x16_broadcast; 
mod xor_fp8x23; 
mod xor_fp8x23_broadcast; 
mod xor_i32; 
mod xor_i32_broadcast; 
mod xor_i8; 
mod xor_i8_broadcast; 
mod xor_u32; 
mod xor_u32_broadcast; 
mod matmul_fp16x16_1d; 
mod matmul_fp16x16_2x2; 
mod matmul_fp16x16_2x1; 
mod matmul_fp16x16_1x2; 
mod matmul_fp8x23_1d; 
mod matmul_fp8x23_2x2; 
mod matmul_fp8x23_2x1; 
mod matmul_fp8x23_1x2; 
mod matmul_i32_1d; 
mod matmul_i32_2x2; 
mod matmul_i32_2x1; 
mod matmul_i32_1x2; 
mod matmul_i8_1d; 
mod matmul_i8_2x2; 
mod matmul_i8_2x1; 
mod matmul_i8_1x2; 
mod matmul_u32_1d; 
mod matmul_u32_2x2; 
mod matmul_u32_2x1; 
mod matmul_u32_1x2; 
mod acosh_fp16x16; 
mod acosh_fp8x23; 
mod acosh_i32_fp8x23; 
mod acosh_i32_fp16x16; 
mod acosh_i8_fp8x23; 
mod acosh_i8_fp16x16; 
mod acosh_u32_fp8x23; 
mod acosh_u32_fp16x16; 
mod asinh_fp16x16; 
mod asinh_fp8x23; 
mod asinh_i32_fp8x23; 
mod asinh_i32_fp16x16; 
mod asinh_i8_fp8x23; 
mod asinh_i8_fp16x16; 
mod asinh_u32_fp8x23; 
mod asinh_u32_fp16x16; 
mod add_fp16x16; 
mod add_fp16x16_broadcast; 
mod add_fp8x23; 
mod add_fp8x23_broadcast; 
mod add_i32; 
mod add_i32_broadcast; 
mod add_i8; 
mod add_i8_broadcast; 
mod add_u32; 
mod add_u32_broadcast; 
mod sub_fp16x16; 
mod sub_fp16x16_broadcast; 
mod sub_fp8x23; 
mod sub_fp8x23_broadcast; 
mod sub_i32; 
mod sub_i32_broadcast; 
mod sub_i8; 
mod sub_i8_broadcast; 
mod sub_u32; 
mod sub_u32_broadcast; 
mod mul_fp16x16; 
mod mul_fp16x16_broadcast; 
mod mul_fp8x23; 
mod mul_fp8x23_broadcast; 
mod mul_i32; 
mod mul_i32_broadcast; 
mod mul_i8; 
mod mul_i8_broadcast; 
mod mul_u32; 
mod mul_u32_broadcast; 
mod div_fp16x16; 
mod div_fp16x16_broadcast; 
mod div_fp8x23; 
mod div_fp8x23_broadcast; 
mod div_i32; 
mod div_i32_broadcast; 
mod div_i8; 
mod div_i8_broadcast; 
mod div_u32; 
mod div_u32_broadcast;
mod leaky_relu_fp16x16; 
mod leaky_relu_fp8x23; 
mod leaky_relu_i32_fp8x23; 
mod leaky_relu_i32_fp16x16; 
mod leaky_relu_i8_fp8x23; 
mod leaky_relu_i8_fp16x16; 
mod linear_fp16x16; 
mod linear_fp8x23; 
mod linear_i32; 
mod linear_i8; 
mod linear_u32; 
mod logsoftmax_fp16x16_axis_0; 
mod logsoftmax_fp16x16_axis_1; 
mod logsoftmax_fp8x23_axis_0; 
mod logsoftmax_fp8x23_axis_1; 
mod logsoftmax_i32_fp8x23_axis_0; 
mod logsoftmax_i32_fp8x23_axis_1; 
mod logsoftmax_i32_fp16x16_axis_0; 
mod logsoftmax_i32_fp16x16_axis_1; 
mod logsoftmax_i8_fp8x23_axis_0; 
mod logsoftmax_i8_fp8x23_axis_1; 
mod logsoftmax_i8_fp16x16_axis_0; 
mod logsoftmax_i8_fp16x16_axis_1; 
mod logsoftmax_u32_fp8x23_axis_0; 
mod logsoftmax_u32_fp8x23_axis_1; 
mod logsoftmax_u32_fp16x16_axis_0; 
mod logsoftmax_u32_fp16x16_axis_1; 
mod relu_fp16x16; 
mod relu_fp8x23; 
mod relu_i32; 
mod relu_i8; 
mod sigmoid_fp8x23; 
mod sigmoid_fp16x16; 
mod sigmoid_i32_fp8x23; 
mod sigmoid_i32_fp16x16; 
mod sigmoid_i8_fp8x23; 
mod sigmoid_i8_fp16x16; 
mod sigmoid_u32_fp8x23; 
mod sigmoid_u32_fp16x16; 
mod softmax_fp8x23; 
mod softmax_fp16x16; 
mod softmax_i32_fp8x23; 
mod softmax_i32_fp16x16; 
mod softmax_i8_fp8x23; 
mod softmax_i8_fp16x16; 
mod softmax_u32_fp8x23; 
mod softmax_u32_fp16x16; 
mod softplus_fp8x23; 
mod softplus_fp16x16; 
mod softplus_i32_fp8x23; 
mod softplus_i32_fp16x16; 
mod softplus_i8_fp8x23; 
mod softplus_i8_fp16x16; 
mod softplus_u32_fp8x23; 
mod softplus_u32_fp16x16; 
