
# Portability of Workflow

| Teaching  | 20 | Exercises  | 10 | 
| --------------- | -------------- | -------------- |-------------- |

- Discuss ways to implement own research directory.
- Explore links to the wider network for computational researchers.
- How can I move my analysis to a computer cluster?


Workflow managers support portability of analysis across compute environments and scale your analysis. This is quite important given the time required to set-up from scratch and work the ropes of using HPC. A good number of HPCs rely on workload managers like Slurm, including the resources I access as a PGR, at the MVLS school, University of Glasgow. Some the following may map on to the resources you can access to support your research. Please contact your HPC administrator team to request support with setting up.

Once you register an account with your HPC resource, the most straightforward way to install Nextflow is by creating a stand-alone 'environment' using the software management tool, conda. To do this you will need to download [environment.yml](https://github.com/omiridoue/sgsss-workflow/blob/main/episodes/files/scripts/hpc/environment.yml) and transfer the file to your HPC user directory. The file stores a set up instructions to download the dependencies for Nextflow and specifying the exact versions.

```
conda env create --name nextflow --file=environment.yml

```

Replace <my-env> with the name of your environment. I will name this after the software, nextflow.

```
proceed ([y]/n)? <- When conda asks you to proceed, type y

```

You may require support with this step, please get in touch with your HPC support team. You will also require singularity / apptainer - to set up a container to run your project. Check whether this is already installed, if not please request further support from your HPC team. 

![Compute environments and resource supported by Nextflow](episodes/fig/compute.png)

Alas, we can tap into the seamless portability of Nextflow across set ups (ex. local, slurm, azure). You can switch between these compute environments by selecting an appropriate profile to run your pipeline. The appropriate profile in my case was `slurm`, you can tuck away this set-up information by creating a new profile in the `conf/` subfolder (ex. `conf/slurm.config`). Then the command I would use to schedule the launch of the pipeline say using 1 day 1 hour and 10 minutes would involve the following:

```
sbatch -A none -J "Siena" --time=01-01:10:00 --wrap 'nextflow run /mnt/scratch/users/2333157o/meta-network-pipeline/main.nf -profile slurm'
```

This is specific to SLURM, the workload manager, and involves a batch job submission. Essentially, this command asks for resource for nextflow to schedule a series of jobs and orchestrate the moving parts of our analysis. 

- Nextflow automatically keeps track of all the processes executed in your pipeline via checkpointing.
- Nextflow caches intermediate data in task directories within the work directory.
- Nextflow caching and checkpointing allows re-entrancy into a workflow after a pipeline error or using new data, skipping steps that have been successfully executed. 
- Re-entrancy is enabled using the `-resume` option.
