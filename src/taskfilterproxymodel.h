#ifndef TASKFILTERPROXYMODEL_H
#define TASKFILTERPROXYMODEL_H

#include "task.h"
#include <QSortFilterProxyModel>

class TaskFilterProxyModel : public QSortFilterProxyModel
{
    Q_OBJECT
    Q_PROPERTY(int count READ count NOTIFY countChanged)
public:
    explicit TaskFilterProxyModel(QObject *parent = 0);

    int count() const;
    bool filterAcceptsRow(int source_row, const QModelIndex &source_parent) const Q_DECL_OVERRIDE;
    void setTagName(const QString &);
    void setFilterStaged(bool filter);
    void setFilterUntagged(bool filter);
    void setFilterArchived(bool filter);
    void invalidateFilter();

Q_SIGNALS:
    void countChanged();

private:
    QString m_tagText;
    bool m_filterStaged;
    bool m_filterUntagged;
    bool m_filterArchived;
    friend class Controller;
};

#endif
