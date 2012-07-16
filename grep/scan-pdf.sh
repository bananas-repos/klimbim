#!/bin/bash

# pdfs mit Hilfe von strings und grep durchsuchen

ls  | xargs strings | grep 'password' *