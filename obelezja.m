function [F] = obelezja(image)

    % Niz obelezja
    F = zeros(3,1);
    
    % Dimenzije slike
    [M, N] = size(image);
    
    % Karakteristicne dimenzije
    M_1_4 = round(1*M/4);
    M_1_3 = round(M/3);
    M_1_2 = round(M/2);
    M_2_3 = round(2*M/3);
    M_3_4 = round(3*M/4);
    N_1_4 = round(1*N/4);
    N_1_3 = round(N/3);
    N_1_2 = round(N/2);
    N_2_3 = round(2*N/3);
    N_3_4 = round(3*N/4);
    
    GoreLevo = mean(mean(image(1:M_1_3,1:N_1_3)));
    Gore = mean(mean(image(1:M_1_4,N_1_3:N_2_3)));
    GoreDesno = mean(mean(image(1:M_1_3,N_2_3:end)));
    CentarLevo = mean(mean(image(M_1_3:M_2_3,1:N_1_4)));
    Centar = mean(mean(image(M_1_3:M_2_3,N_1_3:N_2_3)));
    CentarDesno = mean(mean(image(M_1_3:M_2_3,N_3_4:end)));
    DoleLevo = mean(mean(image(M_2_3:end,1:N_1_3)));
    Dole = mean(mean(image(M_3_4:end,N_1_3:N_2_3)));
    DoleDesno = mean(mean(image(M_2_3:end,N_2_3:end)));
    
    % Srednji kvadrat / (Gornji kvadrat^2 + Donji kvadrat) - Donji Kvadrat + Srednji kvadrat 
    F(1) = mean(mean(image(M_1_3:M_2_3,N_1_3:N_2_3)))/(mean(mean(image(1:M_1_4,N_1_3:N_2_3)))^2 + mean(mean(image(M_3_4:end,N_1_3:N_2_3)))) ...
          -mean(mean(image(M_3_4:end,N_1_3:N_2_3))) + mean(mean(image(M_1_3:M_2_3,N_1_3:N_2_3)));
    % 2*Kvadrat levo + 0.5*Kvadrat gore
    F(2) = 2*mean(mean(image(M_1_3:M_2_3,1:N_1_4))) + 0.5*mean(mean(image(1:M_1_4,N_1_3:N_2_3)));
    % 2*Kvadrat gore - Kvadrat gore levo - Kvadrat gore desno
    F(3) = 2*mean(mean(image(1:M_1_4,N_1_3:N_2_3))) - mean(mean(image(1:M_1_3,1:N_1_3))) - mean(mean(image(1:M_1_3,N_2_3:end)));
end