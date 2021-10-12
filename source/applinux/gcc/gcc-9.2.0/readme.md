I've built GCC 4.8.2 on several Mavericks machines, 
but I chose a slightly different strategy. 

Specifically, 
I included the code for GMP, MPC, MPFR (and CLOOG and ISL) in the build directory. 
I used a script to quasi-automate it:

GCC_VER=gcc-4.8.2
tar -xf ${GCC_VER}.tar.bz2 || exit 1
cd ${GCC_VER} || exit
cat <<EOF |
    cloog 0.18.0 tar.gz
    gmp 5.1.3 tar.xz
    isl 0.11.1 tar.bz2
    mpc 1.0.1 tar.gz
    mpfr 3.1.2 tar.xz
EOF
while read file vrsn extn
do
    tar -xf "../$file-$vrsn.$extn" &&
    ln -s "$file-$vrsn" "$file"
done

With that done:

mkdir gcc-4.8.2-obj
cd gcc-4.8.2-obj
../gcc-4.8.2/configure --prefix=$HOME/gcc/v4.8.2
make -j8 bootstrap
