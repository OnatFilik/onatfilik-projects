function ymatrixfinal = ymatrixonat(dosyaadi)

dosya= fopen(dosyaadi, 'r');
format

sayi=0;
while 1
    oku=fgetl(dosya);
    if contains(oku, "BUS DATA FOLLOWS")
        break
    end
end

sayi3=0;
while 1
    sayi3=sayi3+1;
    oku=fgetl(dosya);
    if contains(oku, "-999")
        break
    end
    susp=str2double(oku(115:122));
    B_degeri(sayi3,1)=susp;
end

while 1
    oku=fgetl(dosya);
    if contains(oku, "BRANCH DATA FOLLOWS")
        break
    end
end

while 1
    sayi=1+sayi;
    oku= fgetl(dosya);
    if contains(oku, "-999")
        break
    end
    ttbus=str2double(oku(1:4));
    zzbus=str2double(oku(6:9));
    linee=str2double(oku(41:50));
    rd=str2double(oku(20:29));
    xd=str2double(oku(30:40));
    X_degeri(sayi,1)=xd;
    R_degeri(sayi,1)=rd;
    Bline_degeri(sayi,1)=linee;
    Tbusdegeri(sayi,1)=ttbus;
    Zbusdegeri(sayi,1)=zzbus;
end

for sayi1=1:length(R_degeri)
    sayi1:1+sayi1;
    Z_degeri(sayi1,1)= R_degeri(sayi1,1) + i*X_degeri(sayi1,1);
    Y_degeri(sayi1,1)= (1/(Z_degeri(sayi1,1)));
end

YFinal_Matrix=zeros(length(B_degeri),length(B_degeri));

for sayi5=1:length(Tbusdegeri)
    YFinal_Matrix(Tbusdegeri(sayi5,1),Zbusdegeri(sayi5,1))=-((Y_degeri(sayi5,1))-YFinal_Matrix(Tbusdegeri(sayi5,1),Zbusdegeri(sayi5,1)));
    YFinal_Matrix(Zbusdegeri(sayi5,1),Tbusdegeri(sayi5,1))=-((Y_degeri(sayi5,1))-YFinal_Matrix(Zbusdegeri(sayi5,1),Tbusdegeri(sayi5,1)));
end

for sayi6=1:length(B_degeri)
    YFinal_Matrix(sayi6,sayi6)= (-(sum(YFinal_Matrix(sayi6,:)))) + i*B_degeri(sayi6,1);
end

for sayi7=1:length(Tbusdegeri)
    YFinal_Matrix(Tbusdegeri(sayi7,1),Tbusdegeri(sayi7,1))= YFinal_Matrix(Tbusdegeri(sayi7,1),Tbusdegeri(sayi7,1)) + i*(Bline_degeri(sayi7,1)/2);
    YFinal_Matrix(Zbusdegeri(sayi7,1),Zbusdegeri(sayi7,1))= YFinal_Matrix(Zbusdegeri(sayi7,1),Zbusdegeri(sayi7,1)) + i*(Bline_degeri(sayi7,1)/2);
end

ymatrixfinal=sparse(YFinal_Matrix);

end
