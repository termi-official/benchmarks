
function setup_gcc()
{
   # GCC 4.7.2
   MPICC=mpicc
   MPICXX=mpicxx
   #MPIF77=mpigfortran-4.7.2-fastmpi

   CFLAGS="-O3 -march=knl -mtune=knl"
   CXXFLAGS="-O3 -march=knl -mtune=knl"
   FFLAGS="$CFLAGS"
   TEST_EXTRA_CFLAGS=""
   # TEST_EXTRA_CFLAGS+=" -std=c++11 -fdump-tree-optimized-blocks"
}

function set_mpi_options()
{
   local account="${account:-dogiermann}"
   local partition="${partition:-knl}"
   MPIEXEC_OPTS= #"-A ${account} -p ${partition}"
   # MPIEXEC_OPTS="-A ceed -p psmall"
   MPIEXEC_OPTS+=" --ntasks-per-node $num_proc_node"
   #if [[ "$num_proc_node" -gt "16" ]]; then
   #   MPIEXEC_OPTS+=" --overcommit"
   #fi
   compose_mpi_run_command
}

MFEM_EXTRA_CONFIG="MFEM_TIMER_TYPE=0"

valid_compilers="gcc"
num_proc_build=${num_proc_build:-16}
num_proc_run=${num_proc_run:-16}
num_proc_node=${num_proc_node:-16}
memory_per_node=16
node_virt_mem_lim=16

# Optional (default): MPIEXEC (mpirun), MPIEXEC_OPTS (), MPIEXEC_NP (-np)
MPIEXEC=srun
MPIEXEC_NP=-n

