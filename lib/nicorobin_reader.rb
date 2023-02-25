require "prawn"

filenames = Dir.entries("/mnt/brain/Library/Manga/One Piece/chapters")

filenames.each do |folder|
    puts("Diretorio #{folder}")
    pages_path = "/mnt/brain/Library/Manga/One Piece/chapters/" ++ folder
    pages = Dir.glob("#{pages_path}/*.jpg")
    puts(pages)
end

# Prawn::Document.generate("hello.pdf") do
#   text "Hello World!"
# end