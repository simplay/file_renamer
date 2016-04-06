require 'pry'

files_to_rename_path = ARGV[0]
association_file_path = ARGV[1]

counter = 1
fname_pairs = {}
File.open(association_file_path, 'r') do |file|
  while line = file.gets
    next if line.nil?
    fname = line.strip.split(" ").last.split("/").last
    fname_pairs[counter] = fname
    counter = counter + 1
  end
end

fname_pairs.each do |idx, fname_path|
  ext = "." + fname_path.split(".").last
  File.rename(files_to_rename_path + fname_path, files_to_rename_path + idx.to_s + ext)
end
