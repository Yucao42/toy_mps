nvcc -o toy ./toy_mps.cu

# NVPROF="nvprof --log-file ./reports/${CONFIG}.csv --csv -f "
mkdir -p nvvp
NVPROF_FLAGS="--profile-api-trace all "
# NVPROF="nvprof --export-profile ./nvvp/${CONFIG}${PROC}%p.nvvp -f --profile-child-processes --cpu-thread-tracing on ${NVPROF_FLAGS}"

echo "=============="
echo "=== No MPS ==="
echo "=============="
echo ""

echo "Run toy alone twice"
$NVPROF ./toy
echo ""
$NVPROF ./toy
echo ""


echo "Run 2 toys parallel twice"
$NVPROF ./toy & $NVPROF ./toy &
sleep 0.5
echo ""
$NVPROF ./toy & $NVPROF ./toy &
sleep 0.5
echo ""

echo "=============="
echo "=== With MPS ==="
echo "=============="
echo ""

# Turn on MPS on daemon
sudo nvidia-cuda-mps-control -d
echo "Run toy alone twice"
$NVPROF ./toy
echo ""
$NVPROF ./toy
echo ""


echo "Run 2 toys parallel twice"
$NVPROF ./toy & $NVPROF ./toy &
sleep 0.5
echo ""
$NVPROF ./toy & $NVPROF ./toy &
sleep 0.5
echo ""

# Shut down MPS
sudo echo quit | nvidia-cuda-mps-control 
