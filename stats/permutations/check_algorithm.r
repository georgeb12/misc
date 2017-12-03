#! /usr/bin/env Rscript

my_args <- commandArgs(TRUE)

my_data <- read.table(my_args, sep = " ")

n_elements <- ncol(my_data)

is_correct <-
  nrow(my_data) == factorial(n_elements) && 
  nrow(unique(my_data)) == factorial(n_elements)

cat(
  "FILENAME            : ", my_args, "\n",
  "NUMBER OF ELEMENTS  : ", n_elements, "\n",
  "ALGORITHM IS CORRECT: ", is_correct, "\n",
  sep = ""
)
