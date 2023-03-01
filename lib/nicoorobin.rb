require 'pathname'
require 'prawn'

class Nicoorobin
    attr_accessor :path, :ext_from, :ext_to, :files, :dest
    
    def initialize(path, ext_from="jpg", ext_to="pdf", dest="own")
        @path = path
        @ext_from = ext_from
        @ext_to = ext_to
        @dest = dest == "own" ? @path : dest
        @filename = File.basename(path)
    end

    def research
        begin
            @files = Pathname.glob("#{@path}/*.#{@ext_from}")
            raise "No file with the #{@ext_from} extension was found" if @files.empty?

            @files.sort! do |a, b|
                file_a = Pathname.new(a).basename
                file_b = Pathname.new(b).basename
                file_a.sub(".#{@ext_from}", '').to_s.to_i <=> file_b.sub(".#{@ext_from}", '').to_s.to_i
            end

            raise 'Error sorting the files.' if @files.empty?

            @files.map! do |file|
                file.to_path
            end
        rescue Exception => e
            puts e
            return nil
        end
    end

    def build
        begin
            raise "No file with the #{@ext_from} extension was found" if @files.empty?

            Prawn::Document.generate("#{@dest}/#{@filename}.#{@ext_to}", page_size: "A4") do |pdf|
                @files.each do |f|
                    pdf.image f, scale: 1, position: :center, width: 450
                end
            end
        rescue Exception => e
            puts e
        end
    end
end