module Names

  def put_in_list(name, names, list)
    if name == names.last
      "#{list}#{name}"
    else
      "#{name}, #{list}"
    end
  end

  def names(items)
    names = items.map {|item| item.name}
    names.reduce("") {|list, name| put_in_list(name, names, list)}
  end
end