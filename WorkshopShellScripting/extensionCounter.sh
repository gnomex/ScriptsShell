#!/bin/bash
# Pega todos os arquivos com alguma extensão e conta sua frequência

ls | cut -sf2 -d. | sort | uniq -c
