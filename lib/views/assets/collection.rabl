collection @assets

attributes :title, :id
child(:file) do |file| 
  file.file.url rescue "N/A"
end