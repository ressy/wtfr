# Basic Syntax and Naming -------------------------------------------------


# The period character doesn't inherently have a special meaning, generally
# speaking.
x..y... <- 5

# But ... is a reserved word in R, like "if" or "for".
?'...'

# One other thing: S3 methods use periods in function names for special
# purposes.
plot.foo.bar <- function() {}
getS3method("plot", "foo.bar")

# The base language is inconsistent between names_with_underscores,
# names.with.periods, and camelCaseNames (or CamelCaseNames).
?read.table
?UseMethod
?getS3method

# You can assign directly to string literals and it'll assign to a variable
# with that name.
"x" <- 5

# TRUE and FALSE are reserved keywords.  T and F are not!  They're just
# variables pre-set to TRUE and FALSE that tempt you to rely on them because
# they're just one character.  (Why, R?? Why do you do these things to us?)
#
#> ?`TRUE`
# "TRUE and FALSE are reserved words denoting logical constants in the R
# language, whereas T and F are global variables whose initial values set to
# these"
F <- TRUE # totally allowed
if (F) { print("logical value was true") }
F <- FALSE # back to sanity
# Thanks eclarke for pointing this out.


# Assignment and Return Values --------------------------------------------


# functions return the value of the last statement implicitly.
(function(){return(5)})() # 5
(function(){5})() # 5
# Just like for "if" or "for" the curly braces are optional for functions
# consisting of a single statement.
(function()5)() # 5

# note that assignments themselves evaluate to the value assigned.
x <- (y <- 5) # x is 5
(function()x<-5)() # 5

# we can assign rightwards too
5 -> x
# or even both ways at once!
x <- 5 -> y # both are now 5

# Here we set a default value.  Wait, how can y=A if A doesn't exist?  The
# default assignment is lazy and won't actually happen until that variable is
# accessed.  Compare that to Python where it happens at function definition
# time.
assign_when_used <- function(x, y=A) {
	A <- x*2
	print(y)
}
assign_when_used(5)


# Vectorized Everything ---------------------------------------------------


# You can index things that look like scalars.  Nearly everything is a vector
# quantity in R.   (The only thing I've found that doesn't follow that is a
# function.  Stored function calls, on the other hand, behave like lists, and so
# even they are subsettable.)
1[1] # 1
1[2] # NA
# Note that this can behave in weird ways for strings.
length(c("string1", "string2")) # 2 strings, OK
length(c("string1")) # just 1 string
length("string1") # still just 1 string!
# use nchar() for string length
nchar("string1")
# Note the implicit coercion happening with nchar. The number of characters in
# an NA object is two, FALSE is five, and TRUE is four!
nchar(NA)
# (Somewhere between R 3.2 and 3.4 nchar(NA) became NA instead of 2, but the
# others remained.)
nchar(F)
nchar(T)
# But NULL is zero-length, so you get a zero-length integer vector back. 
nchar(NULL) # "integer(0)" is an empty vector of length values.
nchar("") # "0" is not the same return value!  That has length of 1.


# Operators ---------------------------------------------------------------


# Operators are functions; references to them can be "escaped" with backticks to
# refer to the thing in itself (as opposed to quote marks to refer to a string
# literal)
print("+")
print(`+`)
1 + 2
(`+`)(1,2)


# Other Things ------------------------------------------------------------


# TODO: column name weirdness
#> x <- data.frame(a=c(1,2,3), a=c(4,5,6), a=c(7,8,9), check.names=F)
#> x
#  a a a
#1 1 4 7
#2 2 5 8
#3 3 6 9
#> x$foo <- 3
#> x
#  a a a foo
#1 1 4 7   3
#2 2 5 8   3
#3 3 6 9   3
#> x[, 'bar'] <- 3
#> x
#  a a.1 a.2 foo bar
#1 1   4   7   3   3
#2 2   5   8   3   3
#3 3   6   9   3   3

# TODO: negative indexing gotchas with empty vectors (it'll remove all entries!)

# TODO named/number indexing weirdness, like selecting row "3" versus 3.

# TODO: copy-on-write behavior

