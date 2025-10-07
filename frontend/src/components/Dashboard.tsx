import React, { useEffect } from 'react';
import { Card, Col, Row, Statistic, Tag } from 'antd';
import { ClockCircleOutlined, CalendarOutlined, ProjectOutlined } from '@ant-design/icons';
import { useAppDispatch, useAppSelector } from '../hooks/redux';
import { fetchStats } from '../store/statsSlice';

export const Dashboard: React.FC = () => {
  const dispatch = useAppDispatch();
  const { stats, loading } = useAppSelector((state) => state.stats);

  useEffect(() => {
    dispatch(fetchStats());
  }, [dispatch]);

  if (loading || !stats) {
    return <div>Загрузка...</div>;
  }

  return (
    <div>
      <h2 style={{ marginBottom: 24 }}>Статистика</h2>
      <Row gutter={16} style={{ marginBottom: 24 }}>
        <Col xs={24} sm={8}>
          <Card>
            <Statistic
              title="Сегодня"
              value={stats.total_hours_today}
              suffix="ч"
              prefix={<ClockCircleOutlined />}
              precision={1}
            />
          </Card>
        </Col>
        <Col xs={24} sm={8}>
          <Card>
            <Statistic
              title="Эта неделя"
              value={stats.total_hours_week}
              suffix="ч"
              prefix={<CalendarOutlined />}
              precision={1}
            />
          </Card>
        </Col>
        <Col xs={24} sm={8}>
          <Card>
            <Statistic
              title="Этот месяц"
              value={stats.total_hours_month}
              suffix="ч"
              prefix={<ProjectOutlined />}
              precision={1}
            />
          </Card>
        </Col>
      </Row>

      {stats.top_projects.length > 0 && (
        <Card title="Топ проектов за месяц" style={{ marginBottom: 24 }}>
          <Row gutter={[16, 16]}>
            {stats.top_projects.map((project) => (
              <Col xs={24} sm={12} md={8} key={project.project_id}>
                <Card
                  size="small"
                  style={{
                    borderLeft: `4px solid ${project.color}`,
                    background: '#fafafa',
                  }}
                >
                  <div
                    style={{
                      display: 'flex',
                      justifyContent: 'space-between',
                      alignItems: 'center',
                    }}
                  >
                    <div>
                      <div style={{ fontWeight: 500, marginBottom: 4 }}>
                        {project.project_name}
                      </div>
                      <Tag color={project.color}>{project.hours} часов</Tag>
                    </div>
                  </div>
                </Card>
              </Col>
            ))}
          </Row>
        </Card>
      )}
    </div>
  );
};