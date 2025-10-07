import React from 'react';
import { Layout, Typography, Space } from 'antd';
import { ClockCircleOutlined } from '@ant-design/icons';
import { Dashboard } from './components/Dashboard';
import { CreateTimeEntryForm } from './components/CreateTimeEntryForm';
import { TimeEntryList } from './components/TimeEntryList';

const { Header, Content } = Layout;
const { Title } = Typography;

export const App: React.FC = () => {
  return (
    <Layout style={{ minHeight: '100vh' }}>
      <Header
        style={{
          background: '#1890ff',
          display: 'flex',
          alignItems: 'center',
          padding: '0 24px',
        }}
      >
        <Space>
          <ClockCircleOutlined style={{ fontSize: 24, color: 'white' }} />
          <Title level={3} style={{ color: 'white', margin: 0 }}>
            Time Track - Учет рабочего времени
          </Title>
        </Space>
      </Header>
      <Content style={{ padding: '24px', background: '#f0f2f5' }}>
        <div style={{ maxWidth: 1400, margin: '0 auto' }}>
          <Dashboard />
          <CreateTimeEntryForm />
          <TimeEntryList />
        </div>
      </Content>
    </Layout>
  );
};

export default App;
