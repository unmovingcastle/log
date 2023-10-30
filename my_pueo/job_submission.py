#*******************************************************************************
# File: job_submission.py
#    This python script submits jobs on OSC
#
#  Programmer: Jason Yao (yao.966@osu.edu)
#
#  Revision history:
#     10/29/23  Jason Yao, Original version
#
#  Notes:
#       * vertical ruler at column 95
#  TODO:
#       1. 
#
#
#*******************************************************************************
'''

:Help: >> python3 part_b_job1.py -h

'''

import argparse
import subprocess as sp

from pathlib import Path



def main(num_jobs,batch_size,job_name,output_dir,err_dir):


    try:
        sp.call(['sbatch', f'--array=1-{num_jobs}%{batch_size}',
                f'--job-name={job_name}',
                f'-o={output_dir}',
                f'-e={err_dir}',
                f'hello.sh'],
                capture_output=True) #pyright: ignore this line
    except:
        print('\nError during job submission\n')




if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("num_jobs", type=int,
                        help="number of jobs")
    parser.add_argument("batch_size", type=int,
                        help="number of jobs to be run simultaneously")
    parser.add_argument("job_name", type=str,
                        help="the name of the run")
    parser.add_argument("output_dir", type=Path,
                        help="output_directory")
    parser.add_argument("err_dir", type=Path,
                        help="error directory")

    args = parser.parse_args()

    main(args.num_jobs, args.batch_size, args.job_name, args.output_dir, 
         args.err_dir)
