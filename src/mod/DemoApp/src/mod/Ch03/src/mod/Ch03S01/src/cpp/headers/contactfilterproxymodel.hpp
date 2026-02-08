#pragma once

#include <QQmlEngine>
#include <QSortFilterProxyModel>
#include <QStringList>

class ContactFilterProxyModel : public QSortFilterProxyModel
{
  Q_OBJECT
  QML_ELEMENT
  Q_PROPERTY(
    bool favoritesOnly READ favoritesOnly WRITE setFavoritesOnly NOTIFY
      favoritesOnlyChanged
  )
  Q_PROPERTY(
    QString searchText READ searchText WRITE setSearchText NOTIFY
      searchTextChanged
  )
  Q_PROPERTY(
    QStringList selectedTags READ selectedTags WRITE setSelectedTags NOTIFY
      selectedTagsChanged
  )
  Q_PROPERTY(
    bool sortAscending READ sortAscending WRITE setSortAscending NOTIFY
      sortAscendingChanged
  )
  Q_PROPERTY(int count READ count NOTIFY countChanged)
public:
  explicit ContactFilterProxyModel(QObject* const parent = nullptr);

  // Property getters
  bool
  favoritesOnly() const
  {
    return this->m_favoritesOnly;
  }

  QString
  searchText() const
  {
    return this->m_searchText;
  }

  QStringList
  selectedTags() const
  {
    return this->m_selectedTags;
  }

  bool
  sortAscending() const
  {
    return this->m_sortAscending;
  }

  int
  count() const
  {
    return this->rowCount();
  }

  // Property setters
  void
  setFavoritesOnly(const bool& favoritesOnly);
  void
  setSearchText(const QString& searchText);
  void
  setSelectedTags(const QStringList& selectedTags);
  void
  setSortAscending(const bool& ascending);

  // Methods for QML
  Q_INVOKABLE int
  mapToSourceIndex(const int& proxyIndex) const;

signals:
  void
  favoritesOnlyChanged();
  void
  searchTextChanged();
  void
  selectedTagsChanged();
  void
  sortAscendingChanged();
  void
  countChanged();

protected:
  bool
  filterAcceptsRow(
    int sourceRow, const QModelIndex& sourceParent
  ) const override;
  bool
  lessThan(const QModelIndex& left, const QModelIndex& right) const override;

private:
  bool        m_favoritesOnly{};
  QString     m_searchText{};
  QStringList m_selectedTags{};
  bool        m_sortAscending{true};

  // Helper methods
  bool
  matchesSearchText(
    const int& sourceRow, const QModelIndex& sourceParent
  ) const;
  bool
  matchesTags(const int& sourceRow, const QModelIndex& sourceParent) const;
  bool
  matchesFavorites(const int& sourceRow, const QModelIndex& sourceParent) const;
};