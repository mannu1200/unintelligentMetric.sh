# unintelligentMetric can be use to find the contribution of every developer in
# given git repository
#
# It uses "git blame" to decide the committer... 
# That means irrespective of who  wrote the code at the
# first time, it will only consider the last committer who edited the code...

# All the directories and files you want to skip will go here...
files=`find . -type f \
    -not -path "./node_modules/*" \
    -not -path "./.git/*" \
    -not -path "*.log" \
    -not -path "*.html"`

for file in $files; do
    git blame --show-name $file >> code
done
# awk does not work on binary files, however cut does...
# Sometimes git blame adds mulitple white spaces after committer name, such as:
# ff7409fd bin/deploy (Dileep          2014-01-08 13:27:21 +0530  2) #
# And unlike awk, cut -d' ' considers group of whitespace as multiple delimiter...Hence the use of tr...
tr -s ' ' < code | cut -d' ' -f3 | sort | uniq -c

rm code