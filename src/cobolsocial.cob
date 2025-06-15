       IDENTIFICATION DIVISION.
       PROGRAM-ID. COBOL-SOCIAL.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ARQUIVO-PESSOAS ASSIGN TO "pessoas.txt"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.

       FILE SECTION.
       FD ARQUIVO-PESSOAS.
       01 REGISTRO-PESSOA.
           05 NOME         PIC A(30).
           05 DATA-CONHECEU PIC X(10).
           05 OBSERVACAO   PIC A(50).

       WORKING-STORAGE SECTION.
       01 OPCAO           PIC 9 VALUE 0.
       01 NOME-INPUT      PIC A(30).
       01 DATA-INPUT      PIC X(10).
       01 OBSERVACAO-INPUT PIC A(50).

       PROCEDURE DIVISION.
       INICIO.
           DISPLAY "=== COBOL SOCIAL ==="
           DISPLAY "1 - Adicionar pessoa"
           DISPLAY "2 - Ver pessoas"
           DISPLAY "3 - Sair"
           DISPLAY "Escolha uma opção: "
           ACCEPT OPCAO

           EVALUATE OPCAO
               WHEN 1
                   PERFORM ADICIONAR-PESSOA
                   PERFORM INICIO
               WHEN 2
                   PERFORM MOSTRAR-PESSOAS
                   PERFORM INICIO
               WHEN 3
                   DISPLAY "Saindo..."
                   STOP RUN
               WHEN OTHER
                   DISPLAY "Opção inválida!"
                   PERFORM INICIO
           END-EVALUATE.

       ADICIONAR-PESSOA.
           DISPLAY "Nome: "
           ACCEPT NOME-INPUT

           DISPLAY "Data que conheceu (DD/MM/AAAA): "
           ACCEPT DATA-INPUT

           DISPLAY "Observação pessoal: "
           ACCEPT OBSERVACAO-INPUT

           MOVE NOME-INPUT TO NOME
           MOVE DATA-INPUT TO DATA-CONHECEU
           MOVE OBSERVACAO-INPUT TO OBSERVACAO

           OPEN EXTEND ARQUIVO-PESSOAS
           WRITE REGISTRO-PESSOA
           CLOSE ARQUIVO-PESSOAS

           DISPLAY "Pessoa registrada com sucesso!".

       MOSTRAR-PESSOAS.
           OPEN INPUT ARQUIVO-PESSOAS
           PERFORM LER-REGISTROS
           CLOSE ARQUIVO-PESSOAS.

       LER-REGISTROS.
           READ ARQUIVO-PESSOAS
               AT END
                   DISPLAY "Fim da lista."
               NOT AT END
                   DISPLAY "Nome: " NOME
                   DISPLAY "Conheceu em: " DATA-CONHECEU
                   DISPLAY " Observação: " OBSERVACAO
                   DISPLAY "-----------------------------"
                   PERFORM LER-REGISTROS
           END-READ.
