#include "contactfilterproxymodel.hpp"
#include "contactlistmodel.hpp"

ContactFilterProxyModel::ContactFilterProxyModel(QObject* const parent)
  : QSortFilterProxyModel{parent}
{
  this->setDynamicSortFilter(true);

  this->connect(
    this,
    &QAbstractItemModel::rowsInserted,
    this,
    &ContactFilterProxyModel::countChanged
  );

  this->connect(
    this,
    &QAbstractItemModel::rowsRemoved,
    this,
    &ContactFilterProxyModel::countChanged
  );

  this->connect(
    this,
    &QAbstractItemModel::modelReset,
    this,
    &ContactFilterProxyModel::countChanged
  );

  this->connect(
    this,
    &QAbstractItemModel::layoutChanged,
    this,
    &ContactFilterProxyModel::countChanged
  );
}

void
ContactFilterProxyModel::setFavoritesOnly(const bool& favoritesOnly)
{
  if (this->m_favoritesOnly == favoritesOnly)
  {
    return;
  }

  this->beginFilterChange();
  this->m_favoritesOnly = favoritesOnly;
  this->endFilterChange(Direction::Rows);
  emit this->favoritesOnlyChanged();
  emit this->countChanged();
}

void
ContactFilterProxyModel::setSearchText(const QString& searchText)
{
  if (this->m_searchText == searchText)
  {
    return;
  }

  this->beginFilterChange();
  this->m_searchText = searchText;
  this->endFilterChange(Direction::Rows);
  emit this->searchTextChanged();
  emit this->countChanged();
}

void
ContactFilterProxyModel::setSelectedTags(const QStringList& selectedTags)
{
  if (this->m_selectedTags == selectedTags)
  {
    return;
  }

  this->beginFilterChange();
  this->m_selectedTags = selectedTags;
  this->endFilterChange(Direction::Rows);
  emit this->selectedTagsChanged();
  emit this->countChanged();
}

void
ContactFilterProxyModel::setSortAscending(const bool& ascending)
{
  this->m_sortAscending = ascending;
  this->sort(0, ascending ? Qt::AscendingOrder : Qt::DescendingOrder);
  emit this->sortAscendingChanged();
}

int
ContactFilterProxyModel::mapToSourceIndex(const int& proxyIndex) const
{
  QModelIndex proxyIdx{this->index(proxyIndex, 0)};

  QModelIndex sourceIdx{this->mapToSource(proxyIdx)};

  return sourceIdx.row();
}

bool
ContactFilterProxyModel::filterAcceptsRow(
  int sourceRow, const QModelIndex& sourceParent
) const
{
  bool result{true};
  if (!this->matchesFavorites(sourceRow, sourceParent))
  {
    result = false;
  }

  if (!this->matchesSearchText(sourceRow, sourceParent))
  {
    result = false;
  }

  if (!this->matchesTags(sourceRow, sourceParent))
  {
    result = false;
  }

  return result;
}

bool
ContactFilterProxyModel::matchesFavorites(
  const int& sourceRow, const QModelIndex& sourceParent
) const
{
  if (!this->m_favoritesOnly)
  {
    return true;
  }

  QModelIndex index{this->sourceModel()->index(sourceRow, 0, sourceParent)};
  return this->sourceModel()
    ->data(
      index, static_cast<int>(ContactListModel::ContactRoles::IsFavoriteRole)
    )
    .toBool();
}

bool
ContactFilterProxyModel::matchesSearchText(
  const int& sourceRow, const QModelIndex& sourceParent
) const
{
  if (this->m_searchText.isEmpty())
  {
    return true;
  }

  QModelIndex index{this->sourceModel()->index(sourceRow, 0, sourceParent)};
  QString     searchLower{this->m_searchText.toLower()};

  // Search in first name
  QString firstName{
    this->sourceModel()
      ->data(
        index, static_cast<int>(ContactListModel::ContactRoles::FirstNameRole)
      )
      .toString()
  };

  if (firstName.toLower().contains(searchLower))
  {
    return true;
  }

  QString lastName{
    this->sourceModel()
      ->data(
        index, static_cast<int>(ContactListModel::ContactRoles::LastNameRole)
      )
      .toString()
  };
  if (lastName.toLower().contains(searchLower))
  {
    return true;
  }

  // Search in full name
  QString fullName{
    this->sourceModel()
      ->data(
        index, static_cast<int>(ContactListModel::ContactRoles::FullNameRole)
      )
      .toString()
  };
  if (fullName.toLower().contains(searchLower))
  {
    return true;
  }

  QString email{
    this->sourceModel()
      ->data(index, static_cast<int>(ContactListModel::ContactRoles::EmailRole))
      .toString()
  };
  if (email.toLower().contains(searchLower))
  {
    return true;
  }

  QString phone{
    this->sourceModel()
      ->data(index, static_cast<int>(ContactListModel::ContactRoles::PhoneRole))
      .toString()
  };
  if (phone.toLower().contains(searchLower))
  {
    return true;
  }

  return false;
}

bool
ContactFilterProxyModel::matchesTags(
  const int& sourceRow, const QModelIndex& sourceParent
) const
{
  if (this->m_selectedTags.isEmpty())
  {
    return true;
  }

  QModelIndex index{this->sourceModel()->index(sourceRow, 0, sourceParent)};

  QStringList contactTags{
    this->sourceModel()
      ->data(index, static_cast<int>(ContactListModel::ContactRoles::TagsRole))
      .toStringList()
  };

  // Contact must have ALL tags
  for (const QString& tag : this->m_selectedTags)
  {
    if (!contactTags.contains(tag))
    {
      return false;
    }
  }

  return true;
}

bool
ContactFilterProxyModel::lessThan(
  const QModelIndex& left, const QModelIndex& right
) const
{
  // Sort by full name
  QVariant leftData{this->sourceModel()->data(
    left, static_cast<int>(ContactListModel::ContactRoles::FullNameRole)
  )};
  QVariant rightData{this->sourceModel()->data(
    right, static_cast<int>(ContactListModel::ContactRoles::FullNameRole)
  )};

  return leftData.toString().toLower() < rightData.toString().toLower();
}