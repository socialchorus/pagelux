# Suppose to act like an ActiveRecord::Relation
class Query < Struct.new(:items, :index)

  def offset(page_num)
    self.index = page_num
    self
  end

  def limit(num)
    items.slice(index, num)
  end

  def count
    items.length
  end
end
