#pragma once

#include<iostream>
using namespace std;

#ifndef TYPE
#define TYPE int
#endif // TYPE

class Row{

private:

    TYPE  head[5];
    TYPE* tail;

public:

    Row(){

        tail = head;

    }

    ~Row(){

        tail = head;

    }

    int entraNaFila(TYPE data){

        if(tail <= &head[4]){
            *tail = data;
            tail++;
        }
        else{
            return 1;//retorna 1 se a fila estiver cheia
        }

        return 0;
    }

    int saiDaFila(){
        int saindo = head[0];

        if(tail == head){
            return 1;//retorna 1 se a fila estiver vazia
        }
        else{

            int i=0;

            while(&head[i] != tail){
                head[i] = head[i+1];
		i++;
            }
            tail--;

        }

        return saindo;
    }

    bool isVazia () {
        return tail == head;
    }

    int quemTaNaVez(){
        if(tail != head){
            return head[0];
        }
        else{
            return 1;//fila vazia
        }
    }
};
