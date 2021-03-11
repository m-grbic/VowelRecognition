function [Iout, I, Ib, I1] = extractLetter(image_path, letter, n)

    % Ucitavanje slike
    I = readLetter(image_path,letter, n);

    % Prag binarizacije
    Thresh = 0.8;

    % Binarizacija
    Ib = I > Thresh*max(max(I));

    % Uzimanje dimenzija slike
    [M, N] = size(Ib);

    % Uklanjanje crnih okvira
    top = 1;
    bottom = M;
    left = 1;
    right = N;

    % Parametri
    ratio = 0.2; % Prag poredjenja
    stride = 10; % Broj redova/kolona koji se posmatraju
    
    % Gornji okvir
    flag = 0; % Flag koji oznacava da je bar jednom uslov bio ispunjen
    tmp = top; % Promenljiva u kojoj se pamti poslednja vrsta
    while(top < M - stride)
        % Od pocetnog reda  se posmatra narednih stride redova
        for t = top:+1:(top+stride)
            % Da li je procenat crnih piksela veci od zadatog praga?
            if(mean(~Ib(t,:)) > ratio)
                % Ukoliko je vrednost vreca, gornja vrsta se pomera
                tmp = t + 1;
                % Flag se setuje, uslov je ispunjen
                flag = 1;
            end
        end
        % Ukoliko je flag setovan, uslov brisanja vrste je ostvaren
        if(flag)
            top = tmp;
            flag = 0;
        else
            % Nijedna vrsta nije ispunila uslov i zavrsava se while petlja
            break;
        end
    end
    
    % Donji okvir
    flag = 0; % Flag koji oznacava da je bar jednom uslov bio ispunjen
    tmp = bottom; % Promenljiva u kojoj se pamti poslednja vrsta
    while(bottom > 1 + stride)
        % Od poslednjeg reda se posmatra prethodnih stride redova
        for b = bottom:-1:(bottom-stride)
            % Da li je procenat crnih piksela veci od zadatog praga?
            if(mean(~Ib(b,:)) > ratio)
                % Ukoliko je vrednost vreca, donja vrsta se pomera
                tmp = b;
                % Flag se setuje, uslov je ispunjen
                flag = 1;
            end
        end
         % Ukoliko je flag setovan, uslov brisanja vrste je ostvaren
        if(flag)
            bottom = tmp - 1;
            flag = 0;
        else
            % Nijedna vrsta nije ispunila uslov i zavrsava se while petlja
            break;
        end
    end

    % Levi okvir
    flag = 0; % Flag koji oznacava da je bar jednom uslov bio ispunjen
    tmp = left; % Promenljiva u kojoj se pamti poslednja kolona
    while(left < N - stride)
        % Od trenutne kolone se posmatra narednih stride kolona
        for l = left:+1:(left+stride)
            % Da li je procenat crnih piksela veci od zadatog praga?
            if(mean(~Ib(:,l)) > ratio)
                % Ukoliko je vrednost vreca, leva kolona se pomera
                tmp = l;
                % Flag se setuje, uslov je ispunjen
                flag = 1;
            end
        end
        % Ukoliko je flag setovan, uslov brisanja kolone je ostvaren
        if(flag)
            left = tmp + 1;
            flag = 0;
        else
            % Nijedna kolona nije ispunila uslov i zavrsava se while petlja
            break;
        end
    end

    % Desni okvir
    flag = 0; % Flag koji oznacava da je bar jednom uslov bio ispunjen
    tmp = right; % Promenljiva u kojoj se pamti poslednja kolona
    while(right > 1 + stride)
        % Od poslednje kolone se posmatra prethodnih stride kolona
        for r = right:-1:(right-stride)
            % Da li je procenat crnih piksela veci od zadatog praga?
            if(mean(~Ib(:,r)) > ratio)
                % Ukoliko je vrednost vreca, desna kolona se pomera
                tmp = r;
                % Flag se setuje, uslov je ispunjen
                flag = 1;
            end
        end
        % Ukoliko je flag setovan, uslov brisanja kolone je ostvaren
        if(flag)
            right = tmp - 1;
            flag = 0;
        else
            % Nijedna kolona nije ispunila uslov i zavrsava se while petlja
            break;
        end
    end

    
    
    % Izdvajanje slike bez crnih okvira
    I1 = Ib(top:bottom,left:right);
    clear Ib
    Ib = I1;
    
    
    
    % Uzimanje dimenzija slike
    [M, N] = size(Ib);

    % Uklanjanje crnih okvira
    top = 1;
    bottom = M;
    left = 1;
    right = N;

    % Parametri
    ratio = 0.016; % Prag poredjenja
    stride = 5; % Broj redova/kolona koji se posmatraju
    
    % Gornji okvir
    flag = 0; % Flag koji oznacava da je bar jednom uslov bio ispunjen
    tmp = top; % Promenljiva u kojoj se pamti poslednja vrsta
    while(top < M - stride)
        % Od pocetnog reda  se posmatra narednih stride redova
        for t = top:+1:(top+stride)
            % Da li je procenat crnih piksela manji od zadatog praga?
            if(mean(~Ib(t,:)) < ratio)
                % Ukoliko je vrednost vreca, gornja vrsta se pomera
                tmp = t + 1;
                % Flag se setuje, uslov je ispunjen
                flag = 1;
            end
        end
        % Ukoliko je flag setovan, uslov brisanja vrste je ostvaren
        if(flag)
            top = tmp;
            flag = 0;
        else
            % Nijedna vrsta nije ispunila uslov i zavrsava se while petlja
            break;
        end
    end
    
    % Donji okvir
    flag = 0; % Flag koji oznacava da je bar jednom uslov bio ispunjen
    tmp = bottom; % Promenljiva u kojoj se pamti poslednja vrsta
    while(bottom > 1 + stride)
        % Od poslednjeg reda se posmatra prethodnih stride redova
        for b = bottom:-1:(bottom-stride)
            % Da li je procenat crnih piksela manji od zadatog praga?
            if(mean(~Ib(b,:)) < ratio)
                % Ukoliko je vrednost vreca, donja vrsta se pomera
                tmp = b;
                % Flag se setuje, uslov je ispunjen
                flag = 1;
            end
        end
         % Ukoliko je flag setovan, uslov brisanja vrste je ostvaren
        if(flag)
            bottom = tmp - 1;
            flag = 0;
        else
            % Nijedna vrsta nije ispunila uslov i zavrsava se while petlja
            break;
        end
    end

    ratio = 0.02;
    % Levi okvir
    flag = 0; % Flag koji oznacava da je bar jednom uslov bio ispunjen
    tmp = left; % Promenljiva u kojoj se pamti poslednja kolona
    while(left < N - stride)
        % Od trenutne kolone se posmatra narednih stride kolona
        for l = left:+1:(left+stride)
            % Da li je procenat crnih piksela manji od zadatog praga?
            if(mean(~Ib(top:bottom,l)) < ratio)
                % Ukoliko je vrednost vreca, leva kolona se pomera
                tmp = l;
                % Flag se setuje, uslov je ispunjen
                flag = 1;
            end
        end
        % Ukoliko je flag setovan, uslov brisanja kolone je ostvaren
        if(flag)
            left = tmp + 1;
            flag = 0;
        else
            % Nijedna kolona nije ispunila uslov i zavrsava se while petlja
            break;
        end
    end

    % Desni okvir
    flag = 0; % Flag koji oznacava da je bar jednom uslov bio ispunjen
    tmp = right; % Promenljiva u kojoj se pamti poslednja kolona
    while(right > 1 + stride)
        % Od poslednje kolone se posmatra prethodnih stride kolona
        for r = right:-1:(right-stride)
            % Da li je procenat crnih piksela manji od zadatog praga?
            if(mean(~Ib(top:bottom,r)) < ratio)
                % Ukoliko je vrednost vreca, desna kolona se pomera
                tmp = r;
                % Flag se setuje, uslov je ispunjen
                flag = 1;
            end
        end
        % Ukoliko je flag setovan, uslov brisanja kolone je ostvaren
        if(flag)
            right = tmp - 1;
            flag = 0;
        else
            % Nijedna kolona nije ispunila uslov i zavrsava se while petlja
            break;
        end
    end


    Iout = Ib(top:bottom,left:right);



end

















