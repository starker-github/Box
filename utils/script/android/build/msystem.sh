#!/bin/sh

copy_userdata()                                                                                                                                                   
{                                                                                                                                                                 
    if [ -f "out/target/product/$1/system.img" ]; then                                                                                                            
        rm out/target/product/$1/userdata.img                                                                                                                     
        rm out/target/product/$1/data.img                                                                                                                         
        ./build/scripts/mkext4img.sh $1 data                                                                                                                      
        mv out/target/product/$1/data.img out/target/product/$1/userdata.img                                                                                      
        rm out/target/product/$1/system.img                                                                                                                       
        cp out/target/product/$1/userdata.img out/target/product/$1/system/                                                                                       
        ./build/scripts/mkext4img.sh $1 system                                                                                                                    
    else                                                                                                                                                          
        echo "-----CAUTION! Error(s) while Compiling, please check the log above.-----"                                                                           
    fi                                                                                                                                                            
}                                                                                                                                                                 
create_nandbin()                                                                                                                                                  
{                                                                                                                                                                 
        P=`pwd`                                                                                                                                                   
        board=$1                                                                                                                                                  
        SPIN=out/target/product/$board/system.img                                                                                                                 
        SPOUT=out/target/product/$board/system.img                                                                                                                
        rm out/target/product/$board/system.img.bin                                                                                                               
#        rm build/scripts/mknandimg/mkimg                                                                                                                         
#        cd kernel/drivers/nand/misc/mkimg                                                                                                                        
#        ./mm                                                                                                                                                     
#        cd -                                                                                                                                                     
#        cp kernel/drivers/nand/misc/mkimg/mkimg build/scripts/mknandimg/mkimg                                                                                    
        build/scripts/mknandimg/mkimg -f build/target/board/$board/config.ini -i $SPIN -o $SPOUT                                                                  
}       

copy_userdata "$1"
create_nandbin "$1"               

sync
cp out/target/product/zpad80/system.img.bin /home/tao/Public/share/zpad80/
sync

