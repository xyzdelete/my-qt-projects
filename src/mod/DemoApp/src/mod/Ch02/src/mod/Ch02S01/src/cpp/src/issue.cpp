#include "issue.hpp"

Issue::Issue(QObject* parent)
  : QObject{parent}
{
}

void
Issue::setId(const int& id)
{
  if (this->m_id != id)
  {
    this->m_id = id;
    emit this->idChanged();
  }
}

void
Issue::setNumber(const int& number)
{
  if (this->m_number != number)
  {
    this->m_number = number;
    emit this->numberChanged();
  }
}

void
Issue::setTitle(const QString& title)
{
  if (this->m_title != title)
  {
    this->m_title = title;
    emit this->titleChanged();
  }
}

void
Issue::setState(const QString& state)
{
  if (this->m_state != state)
  {
    this->m_state = state;
    emit this->stateChanged();
  }
}

void
Issue::setBody(const QString& body)
{
  if (this->m_body != body)
  {
    m_body = body;
    emit this->bodyChanged();
  }
}

void
Issue::setHtmlUrl(const QString& htmlUrl)
{
  if (this->m_htmlUrl != htmlUrl)
  {
    this->m_htmlUrl = htmlUrl;
    emit this->htmlUrlChanged();
  }
}

void
Issue::setRepoFullName(const QString& repoFullName)
{
  if (this->m_repoFullName != repoFullName)
  {
    this->m_repoFullName = repoFullName;
    emit this->repoFullNameChanged();
  }
}

void
Issue::setCommentsCount(const int& count)
{
  if (this->m_commentsCount != count)
  {
    this->m_commentsCount = count;
    emit this->commentsCountChanged();
  }
}

void
Issue::setUserLogin(const QString& login)
{
  if (this->m_userLogin != login)
  {
    this->m_userLogin = login;
    emit this->userLoginChanged();
  }
}

void
Issue::setCreatedAt(const QDateTime& dt)
{
  if (this->m_createdAt != dt)
  {
    this->m_createdAt = dt;
    emit this->createdAtChanged();
  }
}

Issue*
Issue::fromJson(const QJsonObject& json, QObject* parent)
{
  auto* const issue{new Issue{parent}};
  issue->setId(json.value("id").toInt());
  issue->setNumber(json.value("number").toInt());
  issue->setTitle(json.value("title").toString());
  issue->setState(json.value("state").toString());
  issue->setBody(json.value("body").toString());
  issue->setHtmlUrl(json.value("html_url").toString());
  issue->setCommentsCount(json.value("comments").toInt());
  issue->setCreatedAt(
    QDateTime::fromString(json.value("created_at").toString(), Qt::ISODate)
  );

  // Derive repo full name from html_url: https://github.com/owner/repo/issues/N
  const QString     url{json.value("html_url").toString()};
  const QStringList parts{url.split('/')};
  if (parts.size() >= 5)
    issue->setRepoFullName(parts.at(3) + "/" + parts.at(4));

  const QJsonObject user{json.value("user").toObject()};
  issue->setUserLogin(user.value("login").toString());

  return issue;
}

QList<Issue*>
Issue::listFromJsonBytes(const QByteArray& bytes, int* totalCountOut)
{
  QJsonParseError     err{};
  const QJsonDocument doc{QJsonDocument::fromJson(bytes, &err)};
  QList<Issue*>       result{};
  if (err.error != QJsonParseError::NoError || !doc.isObject())
  {
    return result;
  }

  const QJsonObject root{doc.object()};
  if (totalCountOut)
  {
    *totalCountOut = root.value("total_count").toInt();
  }

  // Not `items{...}`: braces would pick QJsonArray's initializer-list
  // constructor and wrap the array in another array with a single element
  const QJsonArray items = root.value("items").toArray();
  result.reserve(items.size());
  for (const QJsonValue& v : items)
  {
    if (v.isObject())
    {
      result.append(Issue::fromJson(v.toObject(), nullptr));
    }
  }

  return result;
}