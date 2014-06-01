class AmazonBook
  extend ActiveModel::Naming

  attr_reader :book

  def initialize book
    @book = book
  end

  def id
    asin
  end

  def amazon_book?
    true
  end

  def to_key
    [id]
  end

  def to_param
    "ASIN#{id}"
  end

  def name
    book.get('ItemAttributes/Title')
  end

  def image
    @image ||= AmazonImage.new(book)
  end

  def image?
    !!image
  end

  def asin
    book.get('ASIN')
  end

  def to_partial_path
    "books/book"
  end

  def users
    []
  end

  def tags
    []
  end

  def tag_exists? tag
    false
  end

  def add_tag tag
    false
  end

  def remove_tag tag
    false
  end

  def self.find asin
    asin = unless_asin_prefix(asin)
    item = Amazon::Ecs.item_lookup(asin, { response_group: 'Medium' }).items.first
    new item
  end

  def self.search str = ''
    Amazon::Ecs.item_search(str, { response_group: 'Medium' }).items.map { |i| new(i) }.map do |b|
      Book.exists?(amazon_asin: b.asin) ? Book.find_by(amazon_asin: b.asin) : b
    end
  rescue SocketError
    []
  end

  def persist_from_amazon!
    Book.new.tap do |book|
      book.name = name
      book.amazon_asin = asin
      book.remote_image_url = image.medium.url
      book.save
    end
  end

  def self.unless_asin_prefix asin
    prefix = "ASIN"
    asin.start_with?(prefix) ? asin[prefix.size..-1] : asin
  end

end

class AmazonImage < Struct.new(:item)
  def medium
    Struct.new(:url).new(item.get_hash('LargeImage').try(:fetch, "URL"))
  end
end