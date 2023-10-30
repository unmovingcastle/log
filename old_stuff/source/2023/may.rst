May 2023
========

23 Tue
------
Bash
^^^^

Learnt the following:

a.  Translate (``tr``): when appending with ``echo foo >> bar``, the final
    character is a newline (``\n``). Therefore, the next thing we append
    appears on the next line. If we don't want this behavior, we could ``tr``
    out the new-line character through

    ..  code-block:: Bash

        echo "foo" | tr "\n" "FOO" >> bar

    which writes ``foo(whatever)`` to the file``bar`` as usual, but then the
    next thing we append will go right next to ``foo(whatever)`` instead of on
    the next line.

b.  basic calculator ``bc`` for float-arithmetics in Bash:

    ..  code-block:: Bash

        echo "scale=2;2/100" | bc

    returns ``.02``

c.  ``sed`` delimiter: any character following ``s`` is the delimiter. For
    example, ``sed 's+hell+world+' file.txt`` is the same as 
    ``sed 's/hell/world/' file.txt`` 


SLURM
^^^^^
Went through the following part of OSC `documation <https://www.osc.edu/
supercomputing/batch-processing-at-osc/batch-system-concepts>`_ on SLURM

a.  HPC basics
b.  Storage Documentation
c.  Data Storage --> Overview of File System (*this one has a nice table*)
d.  Batch System Concepts



24 Wed
------
Meeting with Julie
^^^^^^^^^^^^^^^^^^
a.  Don't get caught up in the details of the loop.
    Focus on being able to navigate through it; remember what each part does
    and what files are called to do what (and where they are). 
    *Finish the first assignment by next Wednesday.*
b.  Nicholas is currently working with XF for PAEA ARA-hpol (part B), 
    so I will probably be working on the GA for ARA-hpol (part A)? 
    Confirm with Amy on Friday.
c.  Should I start looking into AraSim and learn about Birefringence? 
    Confirm with Amy on Friday. 


SLURM
^^^^^
Went through the following OSC `documation <https://www.osc.edu/
supercomputing/batch-processing-at-osc/batch-system-concepts>`_ on SLURM

a.  Batch System Concepts
b.  Batch Execution Environment
c.  Job Scripts

    *seems like we don't really use parallel computing introduced in this?
    we just submit jobs through job arrays*

d.  Job Submission (mostly focused on **Job Arrays**). In particular, note that
    for example

    .. code-block:: Console

        sbatch --array=1-10%4 test.sh

    is going to submit an array of 10 jobs, but the cluster will only run 4
    of them at simultaneously (so 1-4, then 5-8, and finally 9 and 10).

Some SLURM options worth remembering:

a.  ``A`` stands for *account* (**PAS1960**)
b.  ``N`` is the number of *nodes*
c.  ``t`` is *wall time*
d.  ``n`` is the number of tasks. Much better explanation on this 
    `here <https://stackoverflow.com/questions/65603381/
    slurm-nodes-tasks-cores-and-cpus>`_
    and
    `there <https://stackoverflow.com/questions/39186698/
    what-does-the-ntasks-or-n-tasks-does-in-slurm>`_.


Prolems
^^^^^^^
a.  Still a bit unfamiliar with the SLURM directives such as ``n``. Should
    review the seciont `Job Scripts <https://www.osc.edu/supercomputing/batch-processing-at-osc/
    job-scripts>`_ in the future.
b.  Still unfamiliar with parallel computing (multiple nodes and/or mutiple
    cores). But since we always use only one node per job, I think I don't
    have to worry about stuff like ``srun`` and ``sbcast`` and all other
    parallel computing commands for now.



25 Thu
------
Meeting with Julie
^^^^^^^^^^^^^^^^^^
a.  Julie's `email <Julie.a.rolla@jpl.nasa.gov>`_
b.  Received Julie's candidacy paper. plan to start reading by next meeting 
    (Wed)
c.  Restarted `homework 1 <https://docs.google.com/document/d/
    1NoLTEY5UKqivYc9Cguw6S1VHMito_cMlhCkY9A5FmHw/edit>`_. Half way to finishing.
d.  :strike:`Look into part E tomorrow. Seems like things are not exactly as
    decribed by the dissertation appendix`



26 Fri
------
Meeting with Julie
^^^^^^^^^^^^^^^^^^
a.  Pretty much done with homework 1 Part E, but I should look into it in more 
    detail once I am more familiar with the entire loop.
b.  Going through the question 3's for the remaining parts. Should be able to
    finish on time as planned.



27 Sat
------
Meeting with Julie
^^^^^^^^^^^^^^^^^^
Mostly done with Part B1




28 Sun
------
Meeting with Julie
^^^^^^^^^^^^^^^^^^
a.  Did Part B2
b.  Did part C



29 Mon
------
*Memorial Day, went hiking:)*



30 Tue
------
a.  Did Part D1 and Part D2
b.  Wrote a little script at the target directory of ``GE60`` called ``Jason_cp
    .sh`` to copy all the relevant files and directories to my own working
    directory, which will later be pushed to Github to allow me to work locally.
    Ran the script through job submission as practice; took around 10 minutes.
c.  **TODO:** Figure out how to use ``sbatch`` to ``git push`` (need to somehow
    add my Github token on OSC)


Bash
^^^^
a.  Comment block like so:

    .. code-block:: Bash

        : << END
            hello world!
            This is another line.
        END

b.  Doing arithemetic, note that many operators need to be escaped. For exmaple:

    .. code-block:: Bash

        expr $A \* $B
    
    returns :math:`A \cdot B`



31 Wed
------
Meeting with Julie
^^^^^^^^^^^^^^^^^^
Starting a second pass over the loop today.

a.  Meeting on Thursday 9 am Taipei time from now on.
b.  Started reading Julie's candidacy paper.
c.  Mostly done with `homework 1 <https://docs.google.com/document/d/
    1NoLTEY5UKqivYc9Cguw6S1VHMito_cMlhCkY9A5FmHw/edit>`_. I haven't figure out
    how to push files to Github through job submission, but I used ``scp`` to
    send them to my laptop to work locally. Currently starting over again, going
    through each part in more detail this time. Will also edit the loop scripts
    slightly for readability, might be useful in the future.
d.  Regarding pushing to Github from OSC via job submission, Alex said to check
    the September-19\ :sup:`th` message from Justin on Slack (birefringence-team
    channel)