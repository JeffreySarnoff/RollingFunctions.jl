 𝐷𝑎𝑡𝑎 𝐷𝑎𝑡𝑎ₗₑₙ 𝑆𝑝𝑎𝑛 𝑆𝑝𝑎𝑛ₗₑₙ  𝒯 𝒯ₗₑₙ  𝒫 𝒫ₗₑₙ  𝒪 𝒪⁺ 𝒪⁻

 𝐷𝑎𝑡𝑎 𝐷𝑎𝑡𝑎ₙ 𝑆𝑝𝑎𝑛 𝑆𝑝𝑎𝑛ₙ  𝒯 𝒯ₙ  𝒫 𝒫ₙ  𝒪 𝒪⁺ 𝒪⁻ ⁺𝒪ₙ ⁻𝒪ₙ

We accept a data sequence 𝐷𝑎𝑡𝑎𝒮 of type Vector{T} and of length 𝐷𝑎𝑡𝑎𝒮ₙ ( 𝐷𝑎𝑡𝑎𝒮[begin:end], length( 𝐷𝑎𝑡𝑎𝒮) == 𝐷𝑎𝑡𝑎𝒮ₙ).
We are given a window specification that includes its length, the span of any tiling, and more.

Given a data seqeunce of N elements and a window that spans W elements (W <= N),
    c_complete_windows, r_remaining_indices = fldmod(N, W)
    if iszero(remaining_elements) the data sequence is covered exactly with c_complete_windows
    otherwise, the data sequence is nearly fully covered with c_complete_windows, leaving r_remaining_indices
    
    N = c_complete_windows * W + r_remaining_indices
    0 = c_complete_windows * W + r_remaining_indices - N
    c_complete_windows * W = N - r_remaining_indices
    c_complete_windows = div((N - r_remaining_indices), W)
    W = div((N - r_remaining_indices), c_complete_windows)
    r_remaining_indices = N - c_complete_windows * W
    
The preceeding assumes that the window always advances by 1 index.
Use A as the whole number of indices (1 <= A <= N-1-W) that window always advances.
With A = N-1-W, there is exactly one advance, from index 1 to index 1+N-1-W = N-W
   the repositioned window now starts at index N-W and spans W indices, N-W+W == N
   and the window has nowhere more to traverse.

What value of A allows exactly 2 advances?
    A1 = N-1-W, if iseven(A1) A2 = div(A1,2)
    or, if isodd(N-W), A2 = div(N-W-1, 2)
    
