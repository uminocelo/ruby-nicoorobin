require "prawn"

filenames = Dir.entries("/mnt/brain/Library/Manga/One Piece/chapters")

# filenames.delete_if {|filename| filename == '.' or filename == '..' }
filenames.delete_if {|filename| filename != '01'}.each do |folder|
    puts("Diretorio #{folder}")

    Prawn::Document.generate("/mnt/brain/Library/Manga/One Piece/chapters/#{folder}/cap_#{folder}.pdf", page_size: "A4") do
        pages_path = "/mnt/brain/Library/Manga/One Piece/chapters/" ++ folder
        pages = Dir.glob("#{pages_path}/*.jpg")
        pages.sort! do |a, b|
            page_a = Pathname.new(a).basename
            page_b = Pathname.new(b).basename
            puts(page_a)
            page_a.sub('.jpg', '').to_s.to_i <=> page_b.sub('.jpg', '').to_s.to_i
        end
        
        pages.each do |page|
            puts(page)
            image page, scale: 1, position: :center, width: 450
        end
    end
end