Cheat Sheet
===========

doc role
--------
This is a link to :doc:`2023/aug`.

ref role
--------
And this is a link to a :ref:`Friday the 4th <fri230804>`

code block
----------
``this`` is an inline code block.

and 

.. code-block:: python

   print("(empty line needed above this line in the source file!)")
   print("this is a python code block")


emphasis
--------
* emphasis must be separated from surrounding text by non-word characters to \
  take effect: Thisis\ *one*\ word
* emphasis can not start with a white space: * this* is wrong

automatic numbered list
-----------------------
#. this is the first line
#. this is the second line
#. this is the fourth line

term definition
---------------
first term (up to a line of text)
   Definition of the term, which must be indented
   and can even consist of multiple paragraphs

second term
   Description.

quoted paragraph
----------------
Quoted paragraphs are created by

   just indenting them more than the

surrouning paragrahs.

broken lines
------------
| These lines are
| broken exactly line in 
| the source file.

literal block
-------------
end a paragraph with a double colons ::

   and the separated froun surrounding 
   ones with blank lines

for a literal block

colon
-----
The handling of the :: marker is mart:

*  If it is preceded by whitespace, then the :: has no special effect.
*  If it is preceded by non-whitespace, :: becomes 
   a single colon like so:

doctest
-------
this is a doctest block

>>> print("hi")
hi

table
-----
+-----------+------------+
| a table   |  is        |
+===========+============+
| like      | so         |
+-----------+------------+

====== ====
a      is
====== ====
simple like
table  so
====== ====

Hyperlinks
----------

This is a `hyperlink <https://google.com>`_ and another `link`_.

.. _link: https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#hyperlinks


this is a subsection
--------------------
this is a subsubsection
^^^^^^^^^^^^^^^^^^^^^^^

subscript is like so :sub:`hi` and a superscript :sup:`here`