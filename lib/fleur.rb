# frozen_string_literal: true
require 'pathname'
require 'prawn'

class Fleur
    attr_accessor :path, :ext_from, :dest, :files

    def initialize(path, dest, ext_from)
        @path = path
        @ext_from = ext_from
        @dest = dest
    end

    def self.research()
        begin
            @files << Pathname.glob("#{@path}/*.#{@ext_from}")
            raise "No file with the #{@ext_from} extension was found in #{@path}/*.#{@ext_from}" if @files.nil? || @files.empty?

            @files.sort! do |a, b|
                file_a = Pathname.new(a).basename
                file_b = Pathname.new(b).basename
                file_a.sub(".#{@ext_from}", '').to_s.to_i <=> file_b.sub(".#{@ext_from}", '').to_s.to_i
            end

            raise 'Error sorting the files.' if @files.empty?

            @files.map! { |file| file.to_path }
        rescue Exception => e
            puts "research"
            puts e
            return nil
        end
    end

    def self.build()
        begin
            return nil if @files.empty?

            Prawn::Document.generate("#{@dest}/#{@filename}.pdf", page_size: "A4") do |pdf|
                @files.each do |f|
                    pdf.image f, scale: 1, position: :center, width: 450
                end
            end
        rescue Exception => e
            puts "build"
            puts e
            return nil
        end
    end
end
