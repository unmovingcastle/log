June 2023
===========

1 Thu
-----
Bash
^^^^

A little but of Bash each day keeps the doctors away.

In the main loop, around ``line 140``, we have

.. code-block:: Bash

    read -p "Starting generation ${gen} at location ${state}.\
                Press any key to continue... " -n1 -s
            
*   option ``p <prompt>`` outputs the ``prompt`` string before reading user
    input
*   option ``n <number>`` returns after reading the specified ``number`` of 
    chars.
*   option ``s`` suppresses user input on terminal.



2 Fri
-----
*on a flight home. Didn't do much excpet started going over Part B1 again.*



3 Mon
-----
Meeting with Julie
^^^^^^^^^^^^^^^^^^
a.  Meeting this Wednesday cancelled. In the meantime, Julie suggests reading
    her dissertation Appendix and her candidacy paper. I have largely finished
    reading the relevant part of the Appendix, so the rest of this week will 
    most likely be spendt reading the candidacy paper and checkout out the 
    ``Loop_Parts`` in more detail.
b.  Part B1 2\ :sup:`nd` pass: will also check out the job submission script 
    this time around (final line of ``part_B_GPU_job1.sh``, but still not
    going to look into the ``xmacros``).


Regex
^^^^^
Started reading a little bit about regular expression.



4 Sun
-----
Meeting with Julie
^^^^^^^^^^^^^^^^^^

a.  Currently a bit confused by the job submission script ``GPU_XF_job.sh``.
    Probably because I am not familiar enough with the file strucutre yet.
b.  Also, I am not entirely sure what the ``individual number`` is for in this
    script.



5 Mon
------
Meeting with Julie
^^^^^^^^^^^^^^^^^^

.. _230605A:

a.  Still on the job submission script of ``Part B1``.
b.  Confused about when exactly are the indiv_parent_dir created (the ones in
    ``$XFproj/Simulations``)
    
    edit: see :ref:`Alex's response <230608a>`


SLURM
^^^^^
**File name replacement:**

a.  ``%x`` -- Job name, which can be given as ``--job-name=<name>``
b.  ``%a`` -- Job Array ID (index) number
c.  ``%A`` -- Job Array's master job allocation number
d.  More options `here <https://slurm.schedmd.com/sbatch.html#SECTION_%3CB%3Efil
    ename-pattern%3C/B%3E>`_

Note That the following are *not* the same:

*   ``$SLURM_ARRAY_JOB_ID`` is the ``%A`` from above.
*   ``$SLURM_ARRAY_TASK_ID`` is the index (``%a``) from above.



6 Tue
------
Meeting with Julie
^^^^^^^^^^^^^^^^^^
a.  Started reading Julie's candidacy.



7 Wed
------
Meeting with Julie
^^^^^^^^^^^^^^^^^^
a.  Read everything aside from Chapter 5
b.  **TODO:** Go over Chapter 3 again before reading chapter 5
c.  Ask Julie about Figure 6,7,8, and 9 (a discussion on all of chapter 3.1.2 if
    possible)
d.  **zenith angle:** the angleat which the muon traveled into the IceCube 
    detector, with respect to the vertical. [#f1]_


Bash
^^^^
A backtick is not a quation mark. For instance:

.. code-block:: Bash

    for i in `seq 1 $NPOP`

Everything we type inside the backticks is executed before the main command
(such as ``chown``, and the output of the backticked-command is then read by
the main command)



8 Thu
------
Meeting with Julie
^^^^^^^^^^^^^^^^^^

.. _230608a:

a.  Regarding :ref:`part a. <230605A>` from the June 5\ :sup:`th` entry, From
    Alex:

        Those are created by XF. it's like a backend thing, we never make them
        ourselves but by virtue of simulation antennas they get made by XF as
        the locaiton to stroe the antenna simulation data.
    
    That is, we do not outselves ``mkdir`` the ``$indiv_dir_parent``.
b.  Meeting with Julie today moved to Monday next week.
c.  :strike:`It seems unlikelt to be a bug given how long this script has been
    used, but I am getting an error from the for loop through all frequencies
    in freqlist. Will ask Alex about it`.

    I'm an idiot. I need to initialize ``$GeoFactor`` first.
d.  Finished ``Loop_parts/Part_B_job1.sh`` second pass, moving on to
    ``Part_B_job2.sh``. Adding line breaks in the process; **Be careful with
    trailing whitespace!** *Mayhap it's better to just leave them as single 
    long lines?*
e.  **TODO:** sometime in the future I'll need to figure out what 
    ``simulation_PEC.xmacro`` and ``output.xmacro`` do to really understand
    ``Part_B``.



9 Fri
------
Meeting with Julie
^^^^^^^^^^^^^^^^^^
a.  :strike:`Probably trivial, but it seems like the uan files are already 
    being moved to the correct directory at the end of part b2, so I am not sure
    why we do it again at the beginning of part c`

    edit: in the ``HPol`` version, this is done in ``part b2`` instead of ``c``.
b.  One of the ``mv`` command seems extra; will check with Alex.
c.  ``Part_C.sh`` second pass: digging into the python code (``XFintoARA.py``).
    Should be abl to finish by tomorrow.


Bash
^^^^
a.  The dollar sign works inside the double quotes so there is no need for 
    string concatenation in the example below:

    ..  code-block:: Bash

        ~$  a=2;b=2
        ~$  echo "a * b = $(($a*$b))"
    
    which returns ``a * b = 4``. Note that the ``$((...))`` part is for Bash
    arithmetics.
b.  At some point I should try to figure out exactly what double quotes are for
    in Bash. They seem to be more than just strings?



10 Sat
------
Meeting with Amy
^^^^^^^^^^^^^^^^
a.  Get in touch with Nicholas to see what he's been up to.
b.  Go to Monday's collaboration meeting this week if possible to see if there's
    a project for me.


Python
^^^^^^
**XFintoARA.py**

a.  Instead of using the ``%``'s for string interpolation, we could use 
    **f-string**\ s
b.  Inside the curly braces we can call variables, for instance ``{g.WorkingDir}
    `` in ``line 66``:

    ..  code-block:: python
        
        uanName = f'{g.WorkingDir}/.../{g.gen}_{indiv}_{freqNum}.uan'
    
c.  The ``g`` above is from ``line 102``:

    ..  code-block:: python
        
        g = parser.parse_args()
    
d.  ``Line 73``: ``mat = [["0" for x in range(n)] for y in range(m)]`` is simply
    Python's way to do ``mat=zeros(m,n)`` in Matlab (Python list comprehension).



12 Sun
------
Python
^^^^^^
**XFintoARA.py**

The following pertains ``line 81`` & ``82``

a.  ``line 81`` first turns the third entry in the list ``lineList`` into a
    float.
b.  ``line 82`` contains the something like ``"%.2f" % 10**(a)`` which
    effectively formats :math:`10^a` to two digits after the decimal point.
    This is *not* module operation.
c.  The same can be done using an fstring: ``f'{10**(a):.2f}'``
d.  Mostly finished reading this python script. Moving on to part d tomorrow.

**General**

a.  To access the help message of ``argpasrse``'s ``add_argument()`` function,
    one can run the command 

    ..  code-block:: Bash

        ~$  python3 <filename.py>.py -h

    in the terminal.
b.  For more information on the ``argparse`` module on can look through the 
    `documentation <https://docs.python.org/3/library/argparse.html>`_ 
    and the `tutorial <https://towardsdatascience.com/
    a-simple-guide-to-command-line-arguments-with-argparse-6824c30ab1c3>`_

c.  :strike:`Reviewed file opening (with open, etc)`
d.  mode ``w`` and ``w+``: the former is write; the latter is read and write.
e.  Apparently with Python3, when using ``os.chmod`` one needs to add 
    ``0o`` (/zero-oh/) in front of ``777`` to grant all read-write-execute
    permission. For instance:

    ..  code-block:: python

        os.chmod("filename", 0o777)

    which is the same as ``chmod 777 filename`` in Bash.

    This is because
    
        In unix conventions, written numbers are assumed to be decimal unless
        they are prefixed with a ``0x`` (or ``0X``) in which case they are
        hexadecimal. [#f2]_
    
    and according to the error message we "use an 0o prefix for octal integers".



13 Tue
------
Meeting with Julie
^^^^^^^^^^^^^^^^^^
a.  Meeting with Julie today didn't happen.
b.  Around ``line 24`` of ``Part_D1_Array.sh`` the comment says to "make a 
    directory to hold the AraSim output and error files *for each generation*"
    but it seems like we are only the directory for the zeroth generation?


Bash
^^^^
a.  Option ``-e`` of ``sed`` allows for multiple commands at once. For instance,
    
    ..  code-block:: Bash
        
        sed -e "s/world/universe/" -e "s/hello/goodbye/" ./temp > ./newtemp

    first replaces the word "world" in ``temp`` with "universe" and then "hello"
    with "goodbye" and then pipes these changes to a new file ``newtemp``.



14 Wed
------
Meeting with Julie
^^^^^^^^^^^^^^^^^^
a.  Continuing ``Part_D1`` second pass.
b.  Looking into the job submission script ``Batch_Jobbs/AraSimCall_Array.sh``
c.  Sort of annoying, but it seems like SLURM directives simply cannot be
    broken into multiple lines with backslash, so I'll just leave them.
d.  :strike:`what do num and seed in AraSimCall_Array.sh refer to?`

    ``Seed`` is defined at the very beginning of the main loop and passed to the 
    scripts along the way. See page 155 (Appendix A) of Julie's dissertation.
e.  Note: haven't looked into ``setup.txt`` yet.



15 Thu
------
AraSim Job Submission Script
^^^^^^^^^^^^^^^^^^^^^^^^^^^^
a.  ``Seeds`` is the number of AraSim jobs of an individual, so ``num`` on 
    ``line 15`` is essentially just (ignoring the pesky index issue)
    `` index`` divided by ``seeds``.

.. _num:

b.  As an example, consider some ``task 33`` in a job array. Suppose ``Seeds``
    is ``8``; that is, for each antenna, we do 8 AraSim runs. Since 
    :math:`33-1=32` divided by 8 is 4, and then we add one to finally get 5,
    ``num`` in this case is 5. In other words, ``task 33`` is a task for antenna
    **num**\ ber 5.
c.  Similarly, right below ``num``, ``seed`` refers to the "seed index" for that
    particular antenna. Continuing with the example in item :ref:`b <num>`
    above, ``task 33`` will be seed number 1 of antenna 5 (start counting from
    1, as usual)
d.  Pretty sure ``line 16``

    ..  code-block:: Bash

        echo a_${num}_${seed}.txt
    
    is unnecessary, and the file name being ``echo``\ ed is probably a typo as
    well?
e.  ``Line 18`` also seems extra? It seems like we are not using this directory
    anymore?
f.  ``Line 19`` is likely the line that says "run AraSim" (with the appropriate
    setup and parameters) and then redirecting the output of the run to the 
    (loal) scratch space of the cluster, ie. ``$TMPDIR``. (see `OSC
    documentation <https://www.osc.edu/supercomputing/storage-environment-at-osc/
    available-file-systems>`_
    on parallel and local scratch space. Basicallly, ``$TMPDIR`` is the fastest.
g.  ``Line 26`` is like another ``SaveState`` file.
h.  ``Line 30-33`` move the AraSim output files from the scratch space back to 
    the directories under ``GE60``.


Meeting with Julie
^^^^^^^^^^^^^^^^^^
a.  Meeting with Julie today rescheduled to same time tomorrow.
b.  Finished going through the job submission script; back to ``Part_D1``.
c.  Skipping the ``debug_mode`` of ``Part_D1`` for now.
d.  Changed ``line 98`` and ``99`` of ``Part_D1`` to use ``$WorkingDir`` to
    shorten the lines.



16 Fri
------
Birefringence Resources from Justin
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
a.  `Amy's paper <https://arxiv.org/abs/2110.09015>`_.
b.  `Paper by a collaborator <https://arxiv.org/abs/1910.01471>`_ who studies 
    the birefringence in ice.
c.  "[A] `decent paper <https://link.springer.com/article/10.1007/
    s00371-011-0619-2>`_ on the theory, but it's a little math heavy."


Meeting with Julie
^^^^^^^^^^^^^^^^^^
**Notes from today's meeting**

a.  ``HPol`` -- I will probably be using AraSim as is, without having to modify
    its code.
b.  Dylan built the PUEO software by modifying PAEA. Julie has a `to-do 
    <https://docs.google.com/document/d/1eLbgvZvcfbJkLJnHPSlomfYT9rpCON7jTh2-
    ccYhGiA/edit>`_ list of instructions for him to do it which she will modify
    and send to me. (edit: `link <https://docs.google.com/document/d/
    1lViJQt9CQBYx5mOYceYGyqeWISUxZRO0ziyPo5tp_gE/edit>`_)
c.  Birefringence -- Julie said that it sounds like what Amy wants is for 
    ``HPol`` to be optimized for birefringence (?), but I don't need to worry
    about learning all about birefringence for now, since I will mainly just be 
    working on scripts of the Loop.
d.  Charged current interaction (something like :math:`\nu + N \to l + X` where
    :math:`nu` is (anti)neutrino of some *flavor* :math:`l`):
    The leptons people see are usually muon muons because those are much more
    stabler than tau (longer lifetime). We don't see electrons either because
    they just get reabsorbed immediately into the ice atoms. (Consequently, 
    muons produce tracks whereas the other two create spheres.)
e.  Julie recommends Dick, Chris Hirata, and Antonio Boveia for candidacy.

**Second pass over the Loop continued**

a.  Continuing with ``Part_D1_Array.sh``.
b.  As reported a few weeks ago on Slack, ``line 116`` will never be executed.
    Alex set the impossible condition to keep the code as legacy, but I think
    I'll just comment it out.
c.  Finished ``Part_D1``, moving on to ``Part_D2``.


Bash
^^^^
a.  Be sure not to include whitespace when assigning values to variables in 
    Bash. For instance, ``a = 3`` is wrong.
b.  Example usage of ``expr``:

    .. code-block:: Bash

        totPop=$( expr $NPOP \* $Seeds )
    
    *Note the whitespace! it matters here whether or not there are spaces around
    the multiplication operator.*
c.  But what is the difference between ``expr`` and simply using double
    parentheses? For instance ``totPop=$(( $NPOP * $Seeds ))``?
    Also, in this case it seems like Bash doesn't care as much about the
    whitespace around ``*``?



17 Sat
------
Meeting with Julie
^^^^^^^^^^^^^^^^^^
``Part_D2_Array.sh`` **second pass**

a.  Might be able to shortern ``Line 22``:

    .. code-block:: Bash

        nFiles=$(ls -1 --file-type ../AraSimConfirmed | grep -v '/$' | wc -l)

    using just ``ls | wc -l``. Will test this tomorrow.
b.  Option ``1`` (one) above of ``ls`` "[forces] output ot be one entry per
    line."
c.  ``--file-type`` makes it so that all the directories end with a ``/``, and
    soft links end with a ``@``, etc. Files don't have anything attaached to
    them. [#f3]_
d.  Thus, as an example, inside ``$WorkingDir/Run_Outputs/2023_02_20_Symmetric_
    Run``, if we issue ``ls`` we get ::

         2023_02_20_Symmetric_Run.xf  Fitness_Scores_RG.png  uan_files
         Antenna_Images               FScorePlot2D.png       Veffectives_RG.png
         AraOut                       Gain_Plots             Veff_plot.png
         AraSimConfirmed              Generation_Data        Violin_Plot.png
         AraSim_Errors                GPUFlags               XF_Errors
         AraSimFlags                  Root_Files             XFGPUOutputs
         AraSim_Outputs               runDate.txt            XF_Outputs
         Evolution_Plots              run_details.txt

    whereas with ``ls -1`` we have ::
    
        2023_02_20_Symmetric_Run.xf
        Antenna_Images
        AraOut
        AraSimConfirmed
        AraSim_Errors
        AraSimFlags
        AraSim_Outputs
        Evolution_Plots
        Fitness_Scores_RG.png
        FScorePlot2D.png
        Gain_Plots
        Generation_Data
        GPUFlags
        Root_Files
        runDate.txt
        run_details.txt
        uan_files
        Veffectives_RG.png
        Veff_plot.png
        Violin_Plot.png
        XF_Errors
        XFGPUOutputs
        XF_Outputs

    And finally, with ``ls -1 --file-type`` (on OSC, not on macOS), we get ::

        2023_02_20_Symmetric_Run.xf/
        Antenna_Images/
        AraOut/
        AraSimConfirmed/
        AraSim_Errors/
        AraSimFlags/
        AraSim_Outputs/
        Evolution_Plots/
        Fitness_Scores_RG.png
        FScorePlot2D.png
        Gain_Plots/
        Generation_Data/
        GPUFlags/
        Root_Files/
        runDate.txt
        run_details.txt
        uan_files/
        Veffectives_RG.png
        Veff_plot.png
        Violin_Plot.png
        XF_Errors/
        XFGPUOutputs/
        XF_Outputs/

e.  option ``v`` of ``grep`` means "invert-match", which acts like a ``not``\ 
    -gate. It selects all entires that do not match. In this case, we are trying
    to match all entries that has a forward slash ``/`` right before the end-of
    -line character ``$``. That is, we are trying to match all the directories.
    And then, ``v`` makes sure that we select everything that is *not* a
    directory, ie. files. Finally, we pipe it to ``wc -l`` to count the number
    of lines as usual to get the **number of (ordinary) files**.

f.  Will check with Alex to see if we really need to be this careful. In
    ``Part_B_GPU_job2_asym_array.sh`` ``line 56`` it seems like we decided to 
    simply use ``ls | wc -l``, which is much cleaner and readable.



18 Sun
------
Meeting with Julie
^^^^^^^^^^^^^^^^^^
``Part_D2_Array.sh`` **second pass continued**

Regarding the ``for`` loop around ``line 28``, consider the following script:

.. code-block:: Bash

    #!/bin/bash
    cd ~/Desktop/temp

    for file in *
    do 
        echo $file
    done

If there is *no* file inside ``temp/``, then the output would be ``*``. This is
what the comment aounrd ``line 32`` is taling about.



19 Mon
------
Bash
^^^^
a.  We can break a line inside double quotes. For example, the following is
    legal

    .. code-block:: Bash

        #!/bin/bash
        pat="/users/PAS2137/unmovingcastle/temp"
        out_name=$pat/%x.out
        err_name=$pat/%x.error
        sbatch --job-name=whatever --output=$out_name --error=$err_name a.sh
    
b.  Normally we don't even need the backslash if we are just ``echo``\ ing the
    stuff that is inside the double quotes. But if we are going to access the 
    path later with ``$pat`` then it appears that the backslash *is* necessary.
c.  ``wait`` waits for a process to finish.
    ``sleep`` sleeps for a certain number seconds.


Meeting with Julie
^^^^^^^^^^^^^^^^^^
``Part_D2_Array.sh`` **second pass continued**

a.  Used ``$WorkingDir`` to shorten ``line 60`` & ``line 61``.
b.  The final ``if`` block is effectively a comment, so I'll comment it out.
c.  Finished ``Part_D2_Array.sh``.



20 Tue
------
Meeting with Julie
^^^^^^^^^^^^^^^^^^
``Part_E_Asym.sh`` **second pass**

The curly braces around ``${10}`` ``${11}`` and ``${12}`` are **necessary**.



21 Wed
------
Meeting with Julie
^^^^^^^^^^^^^^^^^^
``Part_E_Asym.sh`` **second pass**

a.  To understand the ``for`` block around ``line 37``, consider the following
    example:

    ..  code-block:: Bash

        for i in `seq 1 4`
        do
            InputFiles="${InputFiles}out${i}.txt "
        done
        echo $InputFiles

b.  The output of the above is ``out1.txt out2.txt out3.txt out4.txt``.

c.  **TODO:** haven't looked into ``fitnessFunction_ARA.cpp`` yet.
d.  Why is ``Veff_Plotting.py`` still in this part and not moved to ``Part_F``?
    (``line 75``)



22 Thu
------
Meeting with Julie
^^^^^^^^^^^^^^^^^^

Meeting with Julie today moved to tomorrow.

``Part_E_Asym.sh`` **second pass continued**

a.  Commented out ``line 109: cd Antenna_Performance_Metric`` because the next
    25 lines have already been commented out so there's no need.
b.  **TODO:** look in ``Data_Generators/gensData_asym.py``.
c.  Commented out ``line 144: cd $WorkingDir/Antenna_Performance_Metric``
    because the subsequent command have already been commented out.
d.  **Be very careful with trailing whitespace when using backslash** ``\`` to
    break a line. For example consider ``line 160``

    ..  code-block:: Bash

        cd AraOut_${gen}_${i}_${j}.txt \
          $WorkingDir/Run_Outputs/$RunName/AraOut/AraOut_${gen}/AraOut...

    If we add a space after ``\``, notice that the syntax highlighting color 
    changes in VScode and this space *will* cause a bug, because what this line
    does is duplicating the source file and then naming the target `` `` 
    (blank); that is, the target file name is simply a whitespace, because the
    backslash in this case is used to escape the whitespace.
e.  Went through ``Part_E``; looking into the Python and C++ scripts called by
    this part.



23 Fri
------
Meeting with Julie
^^^^^^^^^^^^^^^^^^
**Notes from today's meeting**

a.  Contact Ryan and Alex to see what has bee ndone on the HPol GA.
b.  Ask what genese to evolve for the initial check.
c.  Are we planning on making an entirely new software package for HPol or do we
    want it to be ``if else`` switch in the ``VPol`` software?
d.  Contact Alex and Nicholas to see what they have been doing related to 
    ``XF``.
e.  Check the `instructions <https://docs.google.com/document/d/1lViJQt9CQBYx5m
    OYceYGyqeWISUxZRO0ziyPo5tp_gE/edit>`_; can ask Alex or Julie
f. Go to ``step 1`` of the instruction above.


``Part_A`` **second pass**

a.  :strike:`Actually I accidentally skipped Part_A when I started the second
    pass, so I will finish going through this again before I look into the GA.`
b.  ``Line 25``: the condition can never be true because ``NSECTIONS`` is either
    1 or 2 but never 0. **TODO:** check this with Alex.
c.  :strike:`Looking into Latest_Asym_GA.cpp now. The plan is eventually to
    convert the GA in python.` edit: dropped this for now; GA is staying in C++
    for now.


``Latext_Asym_GA.cpp``
a.  ``Line 72`` function header for ``new_tournament`` contains a typo.



25 Sun
------
Meeting with Julie
^^^^^^^^^^^^^^^^^^

a.  Created ``Latest_Asym_GA.py`` under ``$WorkingDir/GA/``. This is an
    attempt to translate the C++ program into Pyhon. 

    Edit: dropped this for now.
b.  Neat `introduction on C++ <https://shengyu7697.github.io/std-vector/>`_
    ``vector`` (in traditional Chinese).
c.  Passing by value and passing by reference `comparison
    <https://www.geeksforgeeks.org/passing-vector-function-cpp/>`_
d.  Pointer and reference `introduction and comparison
    <https://www.geeksforgeeks.org/pointers-vs-references-cpp/>`_
e.  Appending ``f`` to a number makes it a float; otherwise, it is a double.
    So to properly declare a float variable, we write ``float a = 2.0f`` for
    example.
f.  Mostly went through the function declarations and global variables.



26 Mon
------
Meeting with Julie
^^^^^^^^^^^^^^^^^^
``Latest_Asym_GA.cpp``

a.  `An introduction 
    <https://blog.gtwang.org/programming/cpp-random-number-generator-and-pro
    bability-distribution-tutorial/>`_ on ``default_random_engine``.
b.  Not sure why we need to ``seed`` twice (around ``line 300``). Actually,
    I am not sure why we use both ``default_random_engine`` and ``rand``.

    Edit: checkout ``Shared-Code/GA`` on `Github
    <https://github.com/osu-particle-astrophysics/Shared-Code>`_.
    ``Latest_Asym_GA.cpp`` is an old script. The GA on Github is maintained and
    much cleaner.



27 Tue
------
Meeting with Julie
^^^^^^^^^^^^^^^^^^
``Latest_Asym_GA.cpp``

a.  Currently on ``line 340``, reviewing ``<vector>``.
b.  Consider the following

    .. code-block:: C++

        vector<float> fitness (NPOP,0.0f);
    
    This creates a ``vector`` of size ``NPOP`` and initializes every entry to 
    be ``0.0`` (``floats``).
c.  In Python, ``fitness = np.zeroes((a,b))`` creates a matrix of size ``a`` by
    ``b`` and initializes the matrix to zeros.
d.  ``np.round`` returns a ``numpy`` double but simply ``round`` returns and 
    ``int``. We can check this with the ``type()`` function (eg. ``type(round(
    59.5))``)
e.  **TODO:** Ask Ryan or Alex why we write to ``generator.csv``.
f.  **TODO:** Clean up the inner most loop (``NVAR``) tomorrow. The way the 
    tripple loop is used is sort of ugly.



28 Wed
------
Meeting with Alex
^^^^^^^^^^^^^^^^^
``Part_E_Asym.sh`` **second pass continued**

a.  Current `genetic algorithm repository
    <https://github.com/osu-particle-astrophysics/Shared-Code/tree/main>`_
b.  Are we planning on making an entirely new software package for ``HPol`` or
    do we want it to be an ``if-else`` switch in the ``VPol`` software?

    Edit: switch.
c.  Contact Alex and Nicholas to see what they have been doing related to 
    ``XF``.
    
    Edit: see `sample model
    <http://radiorm.physics.ohio-state.edu/elog/GENETIS/210>`_. ``HPol XF``
    progress has been a bit slow so it would help if I can learn ``XF``.
d.  Plan:

    *   :strike:`Finish what I started, which is to translate Latest_Asym_GA.cpp
        as a way to learn GA while reviewing both C++ and Python`

        Edit: dropped the translation for now.
    *   Once done, look into the current GA repo.
    *   Start learning ``XF`` once I return to Columbus.
    *   Long-term plan: learn to navigate ``AraSim``.



29 Thu
------
Meeting with Julie
^^^^^^^^^^^^^^^^^^

a.  No lecture-style meetings remaining.


GA
^^^

a.  Started adding ``HPol`` scripts, pushing to the ``Shared-Code``
    `repository <https://github.c
    om/osu-particle-astrophysics/Shared-Code/tree/main>`_.



30 Fri
------
HPol Work
^^^^^^^^^^^^^

**Loop**

a.  Created a `repo
    <https://github.com/osu-particle-astrophysics/GENETIS_HPol>`_ to house HPol
    stuff. Might be a good time for a third pass?



..  rubric:: Reference

..  [#f1] Rosenau, Kristin. `Quality Cuts & Event Simulation 
    <https://user-web.icecube.wisc.edu/~krosenau/index.html>`_
..  [#f2] wallyk on `octal digit 0 permission  
    <https://stackoverflow.com/questions/32729309/%20what-is-the-purpose-of-the-octal-digit-0-permission>`_
..  [#f3] ArchLinuxTux on `file type 
    <https://stackoverflow.com/questions/51952975/what-is-the-purpose%20-of-file-type-in-ls-command>`_