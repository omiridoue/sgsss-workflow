# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

module load apps/miniforge
module load apps/apptainer

conda activate nextflow;

# Change file path for these system variables not recommended to hardcode these - but you may find yourself needing to tweak these

#export NXF_WORK="$HOME/nextflow/work"
# NXF_VER=24.10.2 nextflow info

#export NXF_LOG_FILE="$HOME/.nextflow.log"

#export NXF_DISABLE_JOBS_CANCELLATION=true
