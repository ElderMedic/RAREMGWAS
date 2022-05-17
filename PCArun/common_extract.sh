## Name dictionary, input and output

## example:  bash extract_file.sh 
                # input_name 
                # directory_name 
                # input_dir 
                # output_name 
                # snplist_location

input_name=$1
directory_name=$2
input_dir=$3
output_name=$4
snplist=$5

printf "New directory: $directory_name"
echo ""
printf "Name: $input_name"
echo ""
printf "Input directory: $input_dir"
echo ""
printf "Output name: $output_name" 
echo ""
printf "Snplist: $snplist"
echo ""
echo ""

#change the .bim files from chr:pos:a1:a2 to chr:pos
cp ${input_dir}${input_name}.bim ${input_dir}${input_name}_chrbp.bim
awk '{$2 = $1":"$4; print}' ${input_dir}${input_name}_chrbp.bim > ${input_dir}${input_name}_pre.bim
sed -e 's/ /\t/g' ${input_dir}${input_name}_pre.bim > ${input_dir}${input_name}_chrbp.bim
rm ${input_dir}${input_name}_pre.bim

# create new directory for the extracted files
mkdir $directory_name
cd $directory_name

# extract the snps
plink --bfile ${input_dir}${input_name} --bim ${input_dir}${input_name}_chrbp.bim --extract $snplist --make-bed --out $output_name

echo ""