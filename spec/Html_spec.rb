require 'rspec'
# require_relative '../src/HtmlDsl.rb'
require_relative '../src/Html.rb'

describe 'Html DSL' do
  
  # Tag's unitary tests

  it 'un tag se sabe pasar a string' do
  	tag = Tag.new("html")
  	expect(tag.to_s).to eq "<html></html>"
  end

  it 'un tag debe soportar un atributo' do
  	tag = Tag.new("span", { :class => "titulo"})
  	expect(tag.to_s).to eq '<span class="titulo"></span>'
  end

  it 'un tag debe soportar mas de un atributo' do
  	tag = Tag.new("span", { :class => "titulo", :id => "blah"})
  	expect(tag.to_s).to eq '<span class="titulo" id="blah"></span>'
  end

  it 'un tag debe soportar texto como contenido' do
  	tag = Tag.new("span", {}, "Hola!")
  	expect(tag.to_s).to eq '<span>Hola!</span>'
  end

  it 'un tag debe soportar otro tag como contenido' do
  	tagDentro = Tag.new("b", {}, "Hola!")
  	tag = Tag.new("span", {}, tagDentro)
  	expect(tag.to_s).to eq '<span><b>Hola!</b></span>'
  end

  # Tags with Blocks unitary

  it 'un tag soporta agregarle otro' do
  	tag = Tag.new("span")

  	bloque = Proc.new { b }
  	tag.instance_eval(&bloque)

  	expect(tag.to_s).to eq '<span><b></b></span>'

  end

  # Html tests

  it 'crea un html vacio' do
  	html = Html.new.root 
    expect(html.to_s).to eq("<html></html>")
  end

  it 'crea un html con body vacio' do
  	html = Html.new.root do
  		body
  	end
    expect(html.to_s).to eq("<html><body></body></html>")
  end

  it 'create un html con body y un tag con un atributo' do
  	html = Html.new.root do
  		body do
  			span class: "title"
  		end
  	end
    expect(html.to_s).to eq('<html><body><span class="title"></span></body></html>')
  end

  it 'tag con 2 atributos' do
  	html = Html.new.root do
  		body do
  			span class: "title", id: "titulo"
  		end
  	end
    expect(html.to_s).to eq('<html><body><span class="title" id="titulo"></span></body></html>')
  end

end