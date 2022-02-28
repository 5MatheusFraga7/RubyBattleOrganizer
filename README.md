# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

-bundle install

-rails g rspec install
-rails g devise:install
-rails g devise user
-rails g devise:views
-rails g devise:controllers user


##

USER CONSEGUE:

    Criar mestre
    Criar player

MESTRE CONSEGUE:

    Criar player   
    Criar monstros
    Criar campos de batalha
    Ligar/desligar campos e monstros
    Ligar/desligar campos e players

##

Agora falta:

    - Criar função de ordenar a iniciativa da batalha
    - Criar turnos? 


Turnos seriam as vezes que cada jogador poderia jogar após definir tal iniciativa.

    Ex:

    p1 [20]
    p2 [18]
    m1 [17] 
    m3 [15]
    p4 [14]
    m2 [12]
    p3 [4]

O primeiro player ficaria destacado -> p1, saberíamos que ele é o primeiro e ele possui o turno dele
para agir


Teríamos uma função que passaria a vez após a ação de p1, e então seria o turno de p2, que seria destacado, e por aí vai.