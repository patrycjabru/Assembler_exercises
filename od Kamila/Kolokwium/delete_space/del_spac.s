        .text
        .type   usun_spacje, @function
        .global usun_spacje

usun_spacje:
        PUSHL   %ebp
        MOVL    %esp, %ebp

        #zmienne lokalne
        MOVL    $0, %eax
        PUSHL   %eax                #ilosc spacji pod rzad

        #pobranie adresu napisu
        MOVL    8(%ebp), %esi       #wskaznik do odczytu znakow
        MOVL    8(%ebp), %edi       #wskaznik do zapisu znakow


        #petla usuwajaca spacje
petla:
        MOVB    (%esi), %al         #pobranie znaku
        INCL    %esi                #zwiekszenie wskaznika czytania

        #spr czy to koniec napisu
        CMPB    $0, %al
        JE      koniec_zamiany

        #spr czy to spacja
        CMPB    $(' '), %al
        JNE     przepisz_nak        #jesli nie spacja to przepisuje znak

        MOVL    -4(%ebp), %ebx      #dodanie do ilosci spacji pod rzad
        INCL    %ebx
        MOVL    %ebx, -4(%ebp)

        CMPL    $1, %ebx            #przepisanie pierwszej spacji
        JE      przepisz_pierwsza_spacje

        JMP     petla

przepisz_nak:
        MOVL    $0, -4(%ebp)

przepisz_pierwsza_spacje:

        #zamiana na duze litery
        MOVL    12(%ebp), %ecx
        CMPL    $0, %ecx
        JE      przepisz
        CMPB    $('a'), %al         #spr czy duza litera
        JB      przepisz

        SUBB    $('a'), %al         #zamiana litery
        ADDB    $('A'), %al
       
przepisz:
        #przepisanie aktualnego znaku
        MOVB    %al, (%edi)
        INCL    %edi
       
        JMP     petla

koniec_zamiany:
        #dodanie konczacego bajtu zerowego
        MOVB    $0, %al
        MOVB    %al, (%edi)

        #koniec funkcji
        MOVL    8(%ebp), %eax       #zwrocenie wskaznika na tekst
        MOVL    %ebp, %esp
        POPL    %ebp
        RET
