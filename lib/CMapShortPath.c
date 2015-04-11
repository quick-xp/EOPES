#include <ruby.h>

VALUE get_short_jump_count(VALUE self,VALUE va){
    int i;
    i = NUM2INT(va);

    return INT2FIX(i);
}

void Init_CMapShortPath(void){
    VALUE rbClass;

    rbClass = rb_define_class("CMapShortPath",rb_cObject);
    rb_define_method(rbClass,"get_short_jump_count",get_short_jump_count,1);
}