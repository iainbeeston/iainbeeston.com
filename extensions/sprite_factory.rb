require 'sprite_factory'

class SpriteFactoryExtension < Middleman::Extension
  def initialize(app, options_hash={}, &block)
    super
    app.before do
      # TODO extract this to a proper option
      options_style = 'scss'
      Dir.glob(File.join(app.source, app.images_dir, 'sprites', '*')).select{|f| File.directory?(f)}.each do |image_path|
        sprite_name = File.basename(image_path).chomp(File::SEPARATOR)
        style_path = File.join(app.source, app.css_dir, 'sprites', sprite_name + (options_style == "css" ? ".css" : ".css.#{options_style}"))
        # TODO work out why i have to specify the library
        ::SpriteFactory.run! image_path, style: options_style, output_style: style_path, cssurl: image_path('sprites'), selector: ".#{sprite_name.singularize}.", library: 'chunkypng', nocss: true, pngcrush: true
      end
      true
    end
  end
end

::Middleman::Extensions.register(:sprite_factory, ::SpriteFactoryExtension)
