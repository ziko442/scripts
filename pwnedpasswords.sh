#!/bin/bash
# Install 'parallel' first: sudo pacman -S parallel

# 1. Create a list of all 1,048,576 prefixes
printf "%05x\n" {0..1048575} > prefixes.txt

# 2. Use parallel to download and reconstruct full hashes
# -j 20 runs 20 downloads at once (adjust based on your CPU/Network)
cat prefixes.txt | parallel -j 20 "curl -s https://api.pwnedpasswords.com/range/{} | awk -v p={} '{print p \$0}' >> pwned_hashes_full.txt"