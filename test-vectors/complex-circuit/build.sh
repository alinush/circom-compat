NUM_VARIABLES=$1
NUM_CONSTRAINTS=$2
PTAU_DIR=${3:-"../../../aptos-keyless-circuit/tmp/aptos-keyless-trusted-setup-contributions"}
PTAU_POWER=$(echo "l($NUM_CONSTRAINTS)/l(2)" | bc -l | xargs -I{} awk "BEGIN{printf(\"%.f\n\", {}+0.5)}")

export NODE_OPTIONS=--max-old-space-size=8192

echo "compiling"
circom complex-circuit-$NUM_VARIABLES-$NUM_CONSTRAINTS.circom --r1cs --wasm

echo "zkey"
snarkjs zkey new complex-circuit-$NUM_VARIABLES-$NUM_CONSTRAINTS.r1cs $PTAU_DIR/powersOfTau28_hez_final_$PTAU_POWER.ptau complex-circuit-$NUM_VARIABLES-$NUM_CONSTRAINTS.zkey
