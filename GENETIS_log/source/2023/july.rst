July 2023
=========

1 Sat
-----
HPol Loop
^^^^^^^^^

a.  Started working on ``HPol`` Loop locally, will push regularly to 
    `Github <https://github.com/osu-particle-astrophysics/GENETIS_HPol>`_



2 Sun
-----
HPol Loop
^^^^^^^^^
a.  Working on ``HPol`` Loop ``Part A``.
b.  **TODO:** learn about git ``submodule`` (for ``Shared-Code/GA``)
c.  Github file name change [#f1]_ :

    ..  code-block:: Bash

        git mv -f yOuRfIlEnAmE yourfilename



4 Tue
-----
HPol Work
^^^^^^^^^
``GA``

a.  Back to going through the GA C++ files.
b.  There has to be a way to improve ``DataRead()``. The file currently has an
    ``if`` check inside a ``for`` loop; probably not the msot efficient way to
    do this.



6 Thu
-----
HPol Work
^^^^^^^^^
**GA:** ``DataRead.h``

a.  Finished modifying DataRad.cpp and pushed to `Github shared-code
    <https://github.com/osu-particle-astrophysics/Shared-Code>`_ (``HPol
    branch``)
b.  The part that reads ``fitnessScores.csv`` inside ``DataRead.cpp`` only reads
    the first column. 

    **TODO:** figure out what the second column of ``fitnessScores.csv`` is
    (in PAEA there are three columns actually)



8 Sat
-----
HPol Work
^^^^^^^^^
**GA:** ``Sort.h``

a.  Started modifying ``Sort.h``.



9 Sun
-----
HPol Work
^^^^^^^^^
**GA:** ``Sort.h``

a.  ``original_location`` and ``t`` are probably not needed at all?

    **TODO:** Check again and get rid to these.

..  _070923b:

b.  Actually I'm not sure where we obtain ``parent_location``. It doesn't
    seem like ``DataRead.h`` provides this ``vector``, and the whole
    ``original_location``-stuff just seems weird. Is this part of the program
    incomplete?



10 Mon
------
HPol Work
^^^^^^^^^
**GA:** ``Sort.h``

a.  Finished editing ``Sort.h`` and pushed to Github Shared-Code repo ``HPol``
    branch.
b.  Will discuss the :ref:`issue <070923b>` mentioned above during the meeting today.


Collaboration Meeting
^^^^^^^^^^^^^^^^^^^^^
a.  From Ezio, regarding creating a remote ``hpol`` branch and allowing others 
    to review the changes:
    
        you can push your local branch with ``git push origin <your-branch>``
        and it will show you a link to create the PR on GitHub. Once you've
        created the PR you can keep adding commits to the branch and push them
        and it will update the PR.



11 Tue
------
Git
^^^
a.  A `good video <https://www.youtube.com/watch?v=RwvTrSm7zEY>`_ explaining how
    to squash git commits using ``git rebase -i <#>``.


HPol Work
^^^^^^^^^
**GA:** ``Sort.h``

a.  :strike:`Will test today if this still produces the desired result since I
    removed the vector original_location and int t yesterday.`

    Edit: tested the above; script works just fine.
b.  Following Ezio's advice, stopped making extraneous changes on ``HPol``
    branch. Will make a patch branch to pake at and destroy and leave ``HPol``
    alone until ``XF`` work is more or less done.


Cleanup Work
^^^^^^^^^^^^
a.  Started a new branch ``clean`` (local) based on ``hpol`` (base commit is
    ``HPol Pause (5fd61c6)``). I will use this branch for my own understanding,
    possibly cleaning up the scripts as I go over them.
b.  From Ezio, regarding the workflow of GENETIS (in a `close pull-request 
    <https: //github.com/osu-particle-astrophysics/Shared-Code/pull/24>`_).

        #.  create a local branch with some commits.
        #.  push the branch onto Github (``git push origin you-branch``) and
            created a PR (it gives you a link to create it after the ``push``)
        #.  wait for reviews and comments.
        #.  add more commits to he local branch to address the reviews/comments.
        #.  push them to Github (``git push origin your-branch``, without 
            forcing/squashing/rebasing) -- the PR will update automatically to
            include the new commit
        #.  repeat step 3-5 until the PR is approved
        #.  click on the ``squash merge`` button on Github to merge the PR on
            main.



12 Wed
------
HPol Work
^^^^^^^^^
**Loop:**

a.  Looking into the various ``Part_B1`` scripts and the corresponding batch
    job.



13 Thu
------
HPol Work
^^^^^^^^^
**Loop:**

a.  Finished cleaning up ``Part_B1``.
b.  Setting up ``HPol`` skeleon for ``Part_B1``
c.  Fixed ``Part A`` GA call error (when ``design`` is bicone).
d.  Now using ``submodules`` for ``Shared-Code`` (more info in ``README.md``)
e.  Started looking into ``Part_B2``.



14 Fri
------
HPol Work
^^^^^^^^^
**Loop:**

a.  Need to determine if we want to keep ``Part_B_GPU_job2_asym.sh``. To do
    this I have to figure out the part where it differs from ``Part_B_GPU_job2
    _asym_array.sh``.
b.  Perhaps for now I'll just keep it in an ``archived`` folder.



15 Sat
------
HPol Work
^^^^^^^^^
**Loop:**
a.  Finished most of ``Part_B2`` third pass yesterday.
b.  Will start looking into ``Part C`` today.
c.  Will also checkout ``ssPermissionCheck.sh`` to see if I can get rid of it.


Bash
^^^^
a.  ``read`` option ``-r`` allows for ignoring backslash. For example:

    ..  code-block:: Bash

        ~$ read
        > Hello \
        > World\
        > !
        ~$ echo $REPLY

    returns ``Hello World!`` but ``read -r <<< "Hello\world!"; echo $REPLY``
    returns ``Hello\world!``



17 Mon
------
HPol Work
^^^^^^^^^
**Loop:**

..  _071723a:

a.  Working on resolving the 
    `comments
    <https://github.com/osu-particle-astrophysics/GENETIS_HPol/pull/1>`_
    (pull request ``#1`` of ``GENETIS-HPol``) from Ezio.



18 Tue
------
HPol Work
^^^^^^^^^
**Loop:**

a.  Working on resolving the :ref:`comments <071723a>`
b.  Created PR ``#3`` (branch ``c``) based on PR ``#1``.
c.  **TODO:** get Ezio's messages from Slack here since Slack hides them after
    90 days.
    


19 Wed
------
HPol Work
^^^^^^^^^
**Loop:**

..  _071923a:

a.  Working on resolving `Ezio's comments
    <https://github.com/osu-particle-astrophysics/GENETIS_HPol/pull/3>`_ in PR
    ``#3``.
b.  PR ``#2`` ready to merge; waiting for ``#3`` to finish.



20 Thu
------
HPol Work
^^^^^^^^^
**Loop:**

a. Working on ``part_c_vpol.py``.



21 Fri
------
HPol Work
^^^^^^^^^
**Loop:**

a. Working on ``part_c_vpol.py``.



22 Sat
------
HPol Work
^^^^^^^^^
**Loop:**

a. Testing ``part_c_vpol.py``.



23 Sun
------
HPol Work
^^^^^^^^^
**Loop:**

a.  Working on resovling the :ref:`comments <071923a>`
    in PR ``#3`` (on ``part_c_vpol.py`` and ``sspermissioncheck.py``).



24 Mon
------
Bash
^^^^

a.  ``if`` statement tags (eg. ``-a`` returns true if the files exists)
    `table here
    <https://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html>`_.
b.  `Luke Smith <https://www.youtube.com/watch?v=p0KKBmfiVl0>`_ on using Bash
    logicall operators (``&&``, ``||``, etc.) to remove ``if`` statements inside
    shell scripts.



25 Tue
------
HPol Work
^^^^^^^^^

**Loop:**

a.  Working on resolving the :ref:`comments <071923a>`
    in PR ``#3`` (on ``part_c_vpol.py``).



26 Wed
------
HPol Work
^^^^^^^^^
**Loop:**

a.  Rewriting ``Part_B_VPol_job1.sh`` into a Python script.



27 Thu
------
HPol Work
^^^^^^^^^
**Loop:**

a.  Mostly done with rewriting ``Part_B_VPol_job1.sh`` into a Python script.



28 Fri
------
*No log today because I got sloppy and didn't take notes*

29 Sat
------
*No log today because I got sloppy and didn't take notes*

30 Sun
------
*No log today because I got sloppy and didn't take notes*

31 Mon
------
*No log today because I got sloppy and didn't take notes*




..  rubric:: Reference

..  [#f1] Amery, Mark. `How do I commit case-sensitive only filename chnages
    in Git
    <https://stackoverflow.com/questions/17683458/
    how-do-i-commit-case-sensitive-%20only-filename-changes-in-git>`_