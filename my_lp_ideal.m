function hd = my_lp_ideal(wc, M)
% Ideal LowPass filter computation
% -------------------------------
% para retorno da função sinc(x)
alpha = (M-1)/2;
n = [0:M-1];
m = n - alpha + eps;
hd = sin(wc*m)./(pi*m);
end