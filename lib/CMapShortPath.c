#include <ruby.h>
#include <stdio.h>
#include <stdlib.h>

int min(int a,int b){
    if (a < b){
        return a;
    }
    return b;
}
void export_short_jump_count(VALUE self,VALUE from_array_o,VALUE to_array_o,VALUE size_o,VALUE fullPath){
    int size = FIX2INT(size_o);
    static int edges[15000][15000];
    VALUE from_array_v = rb_ary_to_ary(from_array_o);
    VALUE to_array_v = rb_ary_to_ary(to_array_o);
    int from_array[size];
    int to_array[size];

    for(int i = 0; i < size; i++){
        from_array[i] = FIX2INT(RARRAY_PTR(from_array_v)[i]);
        to_array[i] = FIX2INT(RARRAY_PTR(to_array_v)[i]);
    }

    //Warshall-Floyd Algorithm
    //Node初期化
    for(int i = 0; i < size; i++){
        for(int j = 0; j < size; j++){
            if (i == j){
                edges[i][j] = 0;
            }else{
                edges[i][j] = 32767;
            }
        }
    }

    //Node間距離の初期化
    for(int i = 0; i < size; i++){
        int from = from_array[i];
        int to = to_array[i];

        edges[from][to] = 1;
        edges[to][from] = 1;
    }

    //本計算
   for(int k = 0; k < size; k++){
       printf("%d / %d complete(short jump count)",k,size);
       puts("");
       for(int i = 0; i < size; i++){
            for(int j = 0; j < size; j++){
                edges[i][j] = min(edges[i][j], edges[i][k] + edges[k][j]);
            }
       }
   }

    //export_temp_file

}

void Init_CMapShortPath(void){
    VALUE rbClass;

    rbClass = rb_define_class("CMapShortPath",rb_cObject);
    rb_define_method(rbClass,"export_short_jump_count",get_short_jump_count,4);
}