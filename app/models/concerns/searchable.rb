module Searchable
  def by_name
    order(Arel.sql('lower(name) ASC'))
  end

  def search(terms)
    if terms.blank?
      all
    else
      where('name ILIKE ?', "%#{terms}%")
    end
  end
end
