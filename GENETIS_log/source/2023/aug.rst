August 2023
===========

Thu, 3rd
--------
Sphinx
^^^^^^

a.  Reading Sphinx `tutorial <https://www.sphinx-doc.org/en/master/>`_.


..  _fri230804:

Fri, 4th
--------
Sphinx
^^^^^^

a.  Learning restructured text (rst).



7 Mon
-----
Collaboration Meeting
^^^^^^^^^^^^^^^^^^^^^
a.  **TODO:** ask Alex what is a realized gain?


Sphinx
^^^^^^
a.  Finished moving research log (``tex`` -> ``rest``)



8 Tue
-----
Sphinx
^^^^^^
a.  Started GENETIS documentation (based on Julie's dissertation)



9 Wed
-----
Sphinx
^^^^^^
a.  Working on GENETIS documentation



10 Thu
------
Sphinx
^^^^^^
a.  GENETIS documentation: ``User's Guide/PAEA/Scripts of the loop``.

..  todo::

    *   Setup Vercel for genetis doc and send to D'Elle
    *   Finish watching XF video
    *   Start looking into XF PEC script
    *   Ezio's comment (``GENETIS_HPol`` PR's)



11 Fri
------

Meeting
^^^^^^^
a.  Alan: 
    
    *   OSC down on Tuesday; ``icAraCoincidence`` at low energies canceled so
        had to resubmit.
    *   Reviewed functions in AraSim and studying ``birefringence.cc``.

b.  Alex:

    *   PUEO antenna: epsilon wteaks to the base model to reduce impedence to
        close to 50 ohms purely as resistance to match to the cables. 
        Stuck with the best example being no resistance and reactance close to
        50 ohms.
    *   Alex reviewed Dylan's PR for speeding up PUEO loop, trying to apply the
        same technique to the XF part of the loop.

c.  Jason:

    *   GENETIS Documentation.
    *   Learning XF.
    *   ``GENETIS_HPol`` branch ``d`` PR: resolving Ezio's comments.



13 Sun
------
Sphinx
^^^^^^
a.  Restructured GENETIS documentation: 4 categories of documentation
    according to `diataxis <https://diataxis.fr/>`_.



15 Tue
------
Sphinx
^^^^^^
a.  Working on GENETIS documentation ``User's Guide/PAEA Introduciotn/Reference:
    PAEA Loop/ Part (A): genetic algorithm and its data``



16 Wed
------
XFdtd
^^^^^
a.  Reading the User's Guide Chapter 2; making the bow tie antenna.



17 Thu
------
*TA training all day*

18 Fri
------
*TA training all day*


21 Mon
------
Today's Meeting
^^^^^^^^^^^^^^^
1.  Make a test loop and document testing procedure.
2.  Get documentation ready to present to Ezio by Wedensday;
    Message Dylan and Bryan on Slack.

23 Wed
------
Sphinx
^^^^^^
Working on getting the documentation ready for Ezio to go over.

..  note::

    still not quite finished though.


25 Fri
------
TODO List:

*   Get the documentation ready for ``HPol`` repo
*   Standardize testing procedure and make a tutorial
*   Updte ``HPol`` (Ezio's comment in 
    `PR 6 <https://github.com/osu-particle-astrophysics/GENETIS_HPol/pull/6>`_).

.. note::

    #.  Merge PR #8 and #6, 
    #.  Get ``HPol`` ready up until ``part d``
    #.  Move ``GENETIS_doc`` into ``HPol``.  **Use autodoc** to document
        scripts (``part A`` to ``part f`` documentation should be automatically
        generated to keep them up-to-date alwasy)

*   Ezio: Docker
*   Learn XF
