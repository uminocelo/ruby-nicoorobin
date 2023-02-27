require 'pathname'

class Nicoorobin
    # deve retornar um array de arrays de imagens
    # e.g: [['path1/1.jpg', 'path1/2.jpg'], [''path2/1.jpg'']]
    def research(path)
        begin
            path = Pathname.new(path)
            raise 'Path is not a directory' unless path.directory?

            items = path.children
            return 'No files or folders found!' if items.empty?

            items.map do |item|
                if item.directory?
                    "precisa acessar o folder e retornar um array de path das imagens"
                elsif item.file?
                    return item.to_path
                end
            end
        end
    end

    def gather(list_of_files)
        :not_implemented
    end
    
    def build(list_of_imgs)
        :not_implemented
    end
end