%% Inicijalizacija
clear all, close all, clc

N = 120;
letters = ['A','E','I','O','U'];
image_path = "BazaSlova\";


%% Izdvajanje obelezja

% Broj obelezja
Nob = 3;
% Broj slika po klasi
Ni = 120;
% Matrica obelezja
F = zeros(Nob,Ni,5);

% Izdvajanje obelezja
for j = 1:5
    for i = 1:120
        image = extractLetter(image_path, letters(j), i);
        F(:,i,j) = obelezja(image);
    end
end

%% Prikaz obelezja

if Nob == 3
    figure(1)
    hold all
    scatter3(F(1,:,1),F(2,:,1),F(3,:,1),'bo')
    scatter3(F(1,:,2),F(2,:,2),F(3,:,2),'r+')
    scatter3(F(1,:,3),F(2,:,3),F(3,:,3),'g*')
    scatter3(F(1,:,4),F(2,:,4),F(3,:,4),'mx')
    scatter3(F(1,:,5),F(2,:,5),F(3,:,5),'k^')
    xlabel("Obelezje 1")
    ylabel("Obelezje 2")
    zlabel("Obelezje 3")
    hold off
    grid on
    legend("A","E","I","O","U")
    title("Prikaz obelezja")
end

%% Podela podataka na obucavajuci i testirajuci skup

% Odnos obucavajuceg i testirajuceg skupa
TrainTestRatio = 0.8;

% Broj slika u obucavajucem skupu
Ntrain = round(TrainTestRatio*Ni);
% Broj slika u testurajucem skupu
Ntest  = Ni - Ntrain;

% Niz za cuvanje obelezja obucavajuceg i testirajuceg skupa
Ftrain = zeros(Nob, Ntrain, 5);
Ftest  = zeros(Nob, Ntest , 5);

% Cuvanje svih indeksa test skupa za kasniji prikaz
all_ind_test = zeros(5,Ntest);

for j = 1:5
    % Mesanje indeksa
    ind = randperm(Ni);
    
    % Izdvajanje indeksa za obucavajuci i testirajuci skup
    ind_train = ind(1:Ntrain);
    ind_test = ind((Ntrain+1):end);
    all_ind_test(j,:) = ind_test;
    
    % Izdvajanje obelezja za obucavajuci skup
    Ftrain(:,:,j) = F(:,ind_train,j);
    
    % Izdvajanje obelezja za testirajuci skup
    Ftest(:,:,j) = F(:,ind_test,j);    
end


%% Estimacija statistickih parametara

% Matrica srednjih vrednosti
M = zeros(Nob,5);
% Niz kovarijacionih matrica
S = zeros(Nob,Nob,5);

% Estimacija
for j = 1:5
    M(:,j) = mean(Ftrain(:,:,j), 2);
    S(:,:,j) = cov(Ftrain(:,:,j)');
end

%% Evaluacija klasifikatora

% Matrica gresaka (vrste: stvarne klase, kolone: dodeljene klase)
Error = zeros(5,5);
ind_dobro = [];
ind_lose = [];

for j = 1:5
    for i = 1:Ntest
        % Izdvajanje odbirka
        X = Ftest(:,i,j);
        
        % Niz verodostojnosti
        Likelihood = zeros(1,5);
        
        for k = 1:5
            Likelihood(k) = Gauss(X,M(:,k),S(:,:,k));
        end
        
        % Maksimum verodostojnosti je dodeljena klasa
        [~, DodeljenaKlasa] = max(Likelihood);
        
        % Memorisanje u matrici gresaka
        Error(j, DodeljenaKlasa) = Error(j, DodeljenaKlasa) + 1;
        
        % Primeri klasifikovanih odbiraka
        if(DodeljenaKlasa == j)
            ind_dobro = [ind_dobro, [j; i]];
        else
            ind_lose = [ind_lose, [j; i; DodeljenaKlasa]];
        end
        
    end     
end


figure(2)
    confusionchart(round(Error))
    title("Matrica konfuzije")

Error
disp("Ukupna greska iznosi: " + num2str(1 - sum(diag(Error))/sum(Error,'all')));

%%

% Prikaz dobro klasifikovanih odbiraka
Ndobro = size(ind_dobro, 2);
Nlose = size(ind_lose, 2);

ind_dobro = ind_dobro(:,randperm(Ndobro));
ind_lose = ind_lose(:,randperm(Nlose));

figure(3)
suptitle("Primer dobro klasifikovanih slova")
for i = 1:4
    subplot(2,2,i)
    
    % Izvlacenje podataka slici
    slovo = letters(ind_dobro(1,i));
    broj_slova = all_ind_test(ind_dobro(1,i),ind_dobro(2,i));
    
    % Ucitavanje slike
    image = extractLetter(image_path, slovo, broj_slova);
    
    % Prikaz
    imshow(image)
    title("Slovo " + slovo)

end


figure(4)
suptitle("Primer lose klasifikovanih slova")
for i = 1:4
    subplot(2,2,i)
    
    % Izvlacenje podataka slici
    slovo = letters(ind_lose(1,i));
    broj_slova = all_ind_test(ind_lose(1,i),ind_lose(2,i));
    dodeljeno_slovo = letters(ind_lose(3,i));
    
    % Ucitavanje slike
    image = extractLetter(image_path, slovo, broj_slova);
    
    % Prikaz
    imshow(image)
    title("Slovo " + slovo + " klasifikovano kao " + dodeljeno_slovo)

end
