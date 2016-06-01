require 'fileutils'

# location of input files
input_file_path = ARGV[0]

# select all files with given extension
file_ext = ARGV[1]

# select every k-th file
sel_every_kth = ARGV[2].to_i


# save selection at this given output file location
output_file_path = ARGV[3]

# make a subselection of the files
selected_files = Dir["#{input_file_path}*#{file_ext}"]
selected_files = selected_files.to_a.each_slice(sel_every_kth).map(&:first)

# create output directory
FileUtils::mkdir_p output_file_path

# copy selected files
selected_files.each_with_index do |filename, idx|
  FileUtils.cp(filename, output_file_path)
end

# rename subselection to have a well-enumeration
selected_files = Dir["#{output_file_path}*#{file_ext}"]
selected_files.each_with_index do |filename, idx|
  file_out_path_name = "#{output_file_path}#{idx + 1}#{file_ext}"
  File.rename(filename, file_out_path_name)
end