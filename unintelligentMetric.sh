# For explaination: http://mannumalhotra.in/unintelligent/

# All the directories and files you want to skip will go here...
files=`find . -type f \
    -not -path "./node_modules/*" \
    -not -path "./.git/*" \
    -not -path "*.log" \
    -not -path "*.html"`

for file in $files; do
    git blame --show-name $file >> code
done
tr -s ' ' < code | cut -d' ' -f3 | sort | uniq -c

rm code