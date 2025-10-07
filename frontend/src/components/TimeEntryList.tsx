import React, { useEffect } from 'react';
import { Table, Tag, Button, Space, Popconfirm, message, Card } from 'antd';
import { DeleteOutlined, ClockCircleOutlined } from '@ant-design/icons';
import type { ColumnsType } from 'antd/es/table';
import { useAppDispatch, useAppSelector } from '../hooks/redux';
import { fetchTimeEntries, deleteTimeEntry, stopTimeEntry } from '../store/timeEntriesSlice';
import { fetchStats } from '../store/statsSlice';
import type { TimeEntry } from '../api/client';

export const TimeEntryList: React.FC = () => {
  const dispatch = useAppDispatch();
  const { entries, loading } = useAppSelector((state) => state.timeEntries);
  const { projects } = useAppSelector((state) => state.projects);

  useEffect(() => {
    dispatch(fetchTimeEntries(1));
  }, [dispatch]);

  const getProjectById = (id: number) => {
    return projects.find((p) => p.id === id);
  };

  const handleDelete = async (id: number) => {
    try {
      await dispatch(deleteTimeEntry(id)).unwrap();
      message.success('Запись удалена');
      dispatch(fetchStats());
    } catch (error) {
      message.error('Ошибка при удалении записи');
    }
  };

  const handleStop = async (id: number) => {
    try {
      await dispatch(stopTimeEntry(id)).unwrap();
      message.success('Таймер остановлен');
      dispatch(fetchStats());
    } catch (error) {
      message.error('Ошибка при остановке таймера');
    }
  };

  const formatDuration = (minutes?: number) => {
    if (!minutes) return '-';
    const hours = Math.floor(minutes / 60);
    const mins = minutes % 60;
    return `${hours}ч ${mins}м`;
  };

  const formatDateTime = (dateString: string) => {
    const date = new Date(dateString);
    return date.toLocaleString('ru-RU', {
      day: '2-digit',
      month: '2-digit',
      year: 'numeric',
      hour: '2-digit',
      minute: '2-digit',
    });
  };

  const columns: ColumnsType<TimeEntry> = [
    {
      title: 'Проект',
      dataIndex: 'project_id',
      key: 'project',
      render: (projectId: number) => {
        const project = getProjectById(projectId);
        if (!project) return '-';
        return (
          <div style={{ display: 'flex', alignItems: 'center' }}>
            <div
              style={{
                width: 12,
                height: 12,
                borderRadius: '50%',
                backgroundColor: project.color,
                marginRight: 8,
              }}
            />
            {project.name}
          </div>
        );
      },
    },
    {
      title: 'Описание',
      dataIndex: 'description',
      key: 'description',
    },
    {
      title: 'Начало',
      dataIndex: 'start_time',
      key: 'start_time',
      render: (time: string) => formatDateTime(time),
    },
    {
      title: 'Окончание',
      dataIndex: 'end_time',
      key: 'end_time',
      render: (time?: string) => (time ? formatDateTime(time) : '-'),
    },
    {
      title: 'Продолжительность',
      dataIndex: 'duration_minutes',
      key: 'duration',
      render: (duration?: number, record: TimeEntry) =>
        record.is_running ? (
          <Tag icon={<ClockCircleOutlined />} color="processing">
            В процессе
          </Tag>
        ) : (
          formatDuration(duration)
        ),
    },
    {
      title: 'Действия',
      key: 'actions',
      render: (_, record: TimeEntry) => (
        <Space>
          {record.is_running && (
            <Button size="small" onClick={() => handleStop(record.id)}>
              Остановить
            </Button>
          )}
          <Popconfirm
            title="Удалить запись?"
            description="Это действие нельзя отменить"
            onConfirm={() => handleDelete(record.id)}
            okText="Да"
            cancelText="Нет"
          >
            <Button size="small" danger icon={<DeleteOutlined />} />
          </Popconfirm>
        </Space>
      ),
    },
  ];

  return (
    <Card title="История записей времени" style={{ marginTop: 24 }}>
      <Table
        columns={columns}
        dataSource={entries}
        rowKey="id"
        loading={loading}
        pagination={{ pageSize: 10 }}
        scroll={{ x: 800 }}
      />
    </Card>
  );
};